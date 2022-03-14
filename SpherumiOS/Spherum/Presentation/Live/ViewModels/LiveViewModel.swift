import RxSwift
import RxCocoa
import RxMVVM
import RxDataSources

class LiveViewModel: ViewModel {
    
    private let liveItemViewModels = BehaviorRelay<[LiveItemViewModel]>(value: [])
    
    lazy var liveItemSections = liveItemViewModels.map { [SectionModel(model: "", items: $0)] }
    
    let liveItemSelected = PublishSubject<LiveItemViewModel>()
    
    override func subscribe() {
        
        invokeObservable(ObserveLiveEvents.default) { [weak self] in
            let viewModels = $0.realmLiveEvents.map(LiveItemViewModel.normal)
            self?.liveItemViewModels.accept(viewModels)
        }
        
        liveItemSelected.bind(onNext: {
            Navigator.navigate(route: StoryRoute.videoPlayerForLive(realmLiveEvent: $0.realmLiveEvent))
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
}
