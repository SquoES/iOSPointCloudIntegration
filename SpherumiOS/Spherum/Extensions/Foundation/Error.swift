import Foundation

extension Error {
    
    func processError(onDisconnectFromInternetError: (() -> Void)? = nil,
                      onHTTPError: ((_ statusCode: Int, _ data: Data) -> Void)? = nil,
                      onOtherError: ((Error) -> Void)? = nil) {
        
        if let afError = self.asAFError {
            switch afError {
            case let .requestRetryFailed(_, originalError):
                originalError.processError(onDisconnectFromInternetError: onDisconnectFromInternetError,
                                           onHTTPError: onHTTPError,
                                           onOtherError: onOtherError)
                return
                
            case let .sessionTaskFailed(error):
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    onDisconnectFromInternetError?()
                    return
                }
                
            case let .responseValidationFailed(reason):
                if case let .customValidationFailed(customValidationError) = reason,
                   let afWrapperError = customValidationError.asAFWrapperError(),
                   case let .api(statusCode, data) = afWrapperError {
                    onHTTPError?(statusCode, data)
                    return
                }
                
            default:
                onOtherError?(self)
                return
            }
            
        }
        
    }
    
}
