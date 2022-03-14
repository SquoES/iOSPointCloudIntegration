import Foundation
import RxMVVM
import SwiftyJSON
import CleanMapper

extension ViewModel {
    
    func getFieldErrors(fromError error: Error) -> [FieldError] {
        if let afError = error.asAFError {
            switch afError {
            case let .requestRetryFailed(_, originalError):
                return getFieldErrors(fromError: originalError)
            case let .responseValidationFailed(reason):
                if case let .customValidationFailed(customValidationError) = reason,
                   let afWrapperError = customValidationError.asAFWrapperError(),
                   case let .api(_, data) = afWrapperError {
                    var fieldErrors = [FieldError]()
                    
                    if let jsonDictErrors = JSON(data).dictionary {
                        for (key, value) in jsonDictErrors {
                            fieldErrors.append(FieldError(field: key, message: value.arrayValue.first?.stringValue ?? ""))
                        }
                    }
                    
                    if let errorsArray = JSON(data).array {
                        for value in errorsArray {
                            fieldErrors.append(FieldError(field: .empty, message: value.stringValue))
                        }
                    }

                    return fieldErrors
                }
            default:
                break
            }
        }
        return []
    }
    
    func handleError(_ error: Error) {
        error.processError(onDisconnectFromInternetError: {
            self.showError(message: .custom(.noConnectionToTheInternet))
        }, onHTTPError: { statusCode, data in
            if statusCode == 400, let fieldError = self.getFieldErrors(fromError: error).first {
                self.showError(message: fieldError.humanize())
            }
            
            if statusCode == 401 {
                // TODO: handle unauthorized
                return
            }
            
            if statusCode == 500 {
                self.showError(message: .custom(.serverUnavailable))
            }
        }, onOtherError: { error in
            self.showError(message: error.localizedDescription)
        })
    }
    
    private func showError(message: String) {
        AlertConstructor(title: nil, message: message, style: .alert)
            .add(alertItem: .ok)
            .show()
    }
    
}
