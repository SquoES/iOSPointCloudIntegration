import Foundation
import RxSwift
import RxMVVM
import CleanUseCase

class UseCaseExecutor {
    
    weak var viewModel: ViewModel?
    
    init(viewModel: ViewModel?) {
        self.viewModel = viewModel
    }
    
    func singleExecution<Input, Output>(useCase: SingleUseCase<Input, Output>, input: Input, settings: UseCaseExecutor.Settings, onCompleted: @escaping (Output) -> Void, onError: ((Error) -> Void)? = nil) {
        guard let disposeBag = self.viewModel?.disposeBag else {
            return
        }
        
        useCase.use(input: input).do(onSubscribe: { [weak self] in
            if settings.contains(.useDefaultLoader) {
                self?.onStartLoading()
            }
        }).subscribe(onSuccess: { output in
            if settings.contains(.useDefaultLoader) {
                self.onStopLoading()
            }
            onCompleted(output)
        }, onError: { [weak self] error in
            if settings.contains(.useDefaultLoader) {
                self?.onStopLoading()
            }
            if settings.contains(.useDefaultErrorHandler) {
                self?.handleError(error: error)
            } else {
                onError?(error)
            }
        }).disposed(by: disposeBag)
    }
    
    func observableExecution<Input, Output>(useCase: ObservableUseCase<Input, Output>, input: Input, settings: UseCaseExecutor.Settings, onNext: @escaping (Output) -> Void) {
        guard let disposeBag = self.viewModel?.disposeBag else {
            return
        }
        
        useCase.use(input: input).subscribe(onNext: { output in
            onNext(output)
        }, onError: { [weak self] error in
            if settings.contains(.useDefaultErrorHandler) {
                self?.handleError(error: error)
            }
        }).disposed(by: disposeBag)
    }
    
    private func onStartLoading() {
        self.viewModel?.isLoading.onNext(true)
    }
    private func onStopLoading() {
        self.viewModel?.isLoading.onNext(false)
    }
    private func handleError(error: Error) {
        self.viewModel?.handleError(error)
    }
    
}

extension UseCaseExecutor {
    
    struct Settings: OptionSet {
        let rawValue: Int
        
        static let empty                    = Settings(rawValue: 0b00)
        static let useDefaultLoader         = Settings(rawValue: 0b01)
        static let useDefaultErrorHandler   = Settings(rawValue: 0b10)
        static let useDefault               = Settings(rawValue: 0b11)
    }
    
}
