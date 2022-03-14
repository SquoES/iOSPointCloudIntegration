import RxSwift
import RxCocoa

extension Reactive where Base: LoaderInteractor {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { view, isLoading in
            view.set(loading: isLoading)
        }
    }
    
}
