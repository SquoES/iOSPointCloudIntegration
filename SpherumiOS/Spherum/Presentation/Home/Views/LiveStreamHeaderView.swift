


import UIKit
import RxMVVM
import RxSwift
import RxCocoa
import RxDataSources

class LiveStreamHeaderView: BaseXibView {
    
    @IBOutlet weak var liveCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: BinarySegmentedControl!
    
    private let disposeBag = DisposeBag()
    
    private let liveDataSources: RxCollectionViewSectionedReloadDataSource<SectionModel<String, LiveItemViewModel>> = CollectionViewConnector.reloadDataSource(LiveItemCollectionViewCell.self)
    
    private let liveItemViewModels = BehaviorRelay<[LiveItemViewModel]>(value: [])
    private lazy var liveItemSections = liveItemViewModels.map({ [SectionModel(model: "", items: $0)] })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        CollectionViewConnector.register(LiveItemCollectionViewCell.self, for: liveCollectionView)
        
        segmentedControl.firsItem = .homeTabIcon
        segmentedControl.secondItem = .list_icon
        
        subscribe()
    }
    
    private func subscribe() {
        
        ObserveLiveEvents.default.use().subscribe(onNext: { [weak self] in
            let viewModels = $0.realmLiveEvents.map(LiveItemViewModel.rounded(realmLiveEvent:))
            self?.liveItemViewModels.accept(viewModels)
        }).disposed(by: disposeBag)
        
        liveItemSections.bind(to: liveCollectionView.rx.items(dataSource: liveDataSources)).disposed(by: disposeBag)
        
        liveCollectionView.rx.modelSelected(LiveItemViewModel.self).bind(onNext: { viewModel in
            Navigator.navigate(route: StoryRoute.videoPlayerForLive(realmLiveEvent: viewModel.realmLiveEvent))
        }).disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentedControl.setNeedsLayout()
        segmentedControl.layoutIfNeeded()
    }
    
}
