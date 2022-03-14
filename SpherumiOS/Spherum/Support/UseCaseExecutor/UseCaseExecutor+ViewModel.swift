import Foundation
import RxMVVM
import CleanUseCase

extension ViewModel {
    
    func invokeSingle<Input, Output>(_ singleUseCase: SingleUseCase<Input, Output>, input: Input, settings: UseCaseExecutor.Settings = .useDefault, onCompleted: @escaping (Output) -> Void, onError: ((Error) -> Void)? = nil) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: input,
                                                         settings: settings,
                                                         onCompleted: onCompleted,
                                                         onError: onError)
    }
    func invokeSingle<Input>(_ singleUseCase: SingleUseCase<Input, Void>, input: Input, settings: UseCaseExecutor.Settings = .useDefault, onCompleted: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: input,
                                                         settings: settings,
                                                         onCompleted: onCompleted,
                                                         onError: onError)
    }
    func invokeSingle<Input>(_ singleUseCase: SingleUseCase<Input, Void>, input: Input, settings: UseCaseExecutor.Settings = .useDefault, onError: ((Error) -> Void)? = nil) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: input,
                                                         settings: settings,
                                                         onCompleted: { },
                                                         onError: onError)
    }
    func invokeSingle(_ singleUseCase: SingleUseCase<Void, Void>, settings: UseCaseExecutor.Settings = .useDefault, onCompleted: @escaping () -> Void, onError: ((Error) -> Void)? = nil) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: (),
                                                         settings: settings,
                                                         onCompleted: { onCompleted() },
                                                         onError: onError)
    }
    func invokeSingle(_ singleUseCase: SingleUseCase<Void, Void>, settings: UseCaseExecutor.Settings = .useDefault, onError: ((Error) -> Void)? = nil) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: (),
                                                         settings: settings,
                                                         onCompleted: { },
                                                         onError: onError)
    }
    func invokeSingle<Output>(_ singleUseCase: SingleUseCase<Void, Output>, settings: UseCaseExecutor.Settings = .useDefault, onCompleted: @escaping (Output) -> Void) {
        UseCaseExecutor(viewModel: self).singleExecution(useCase: singleUseCase,
                                                         input: (),
                                                         settings: settings,
                                                         onCompleted: { onCompleted($0) })
    }
    
    func invokeObservable<Input, Output>(_ observableUseCase: ObservableUseCase<Input, Output>, input: Input, settings: UseCaseExecutor.Settings = .empty, onNext: @escaping (Output) -> Void) {
        UseCaseExecutor(viewModel: self).observableExecution(useCase: observableUseCase,
                                                             input: input,
                                                             settings: settings,
                                                             onNext: onNext)
    }
    func invokeObservable<Output>(_ observableUseCase: ObservableUseCase<Void, Output>, settings: UseCaseExecutor.Settings = .empty, onNext: @escaping (Output) -> Void) {
        UseCaseExecutor(viewModel: self).observableExecution(useCase: observableUseCase,
                                                             input: (),
                                                             settings: settings,
                                                             onNext: onNext)
    }
    
}
