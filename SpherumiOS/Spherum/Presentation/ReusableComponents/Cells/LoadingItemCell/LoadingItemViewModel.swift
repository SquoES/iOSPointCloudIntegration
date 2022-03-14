import RxCocoa
import RxMVVM

class LoadingItemViewModel: ViewModel {
    
    let loading: BehaviorRelay<Bool>
    
    init(loading: Bool) {
        self.loading = .init(value: loading)
    }
    
}
