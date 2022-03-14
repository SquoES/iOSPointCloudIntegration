import RxSwift
import RxCocoa
import RxMVVM

class LiveItemViewModel: ViewModel {
    
    let realmLiveEvent: RealmLiveEvent
    
    let isRounded: BehaviorRelay<Bool>
    
    lazy var title = realmLiveEvent.rx.observe(\RealmLiveEvent.title)
    lazy var imageURL = realmLiveEvent.rx.observe(\RealmLiveEvent.preview!.sourceURL).map { $0?.url }
    
    init(realmLiveEvent: RealmLiveEvent, isRounded: Bool = false) {
        self.realmLiveEvent = realmLiveEvent
        self.isRounded = BehaviorRelay(value: isRounded)
    }
    
    static func rounded(realmLiveEvent: RealmLiveEvent) -> LiveItemViewModel {
        .init(realmLiveEvent: realmLiveEvent,
              isRounded: true)
    }
    
    static func normal(realmLiveEvent: RealmLiveEvent) -> LiveItemViewModel {
        .init(realmLiveEvent: realmLiveEvent,
              isRounded: false)
    }
}
