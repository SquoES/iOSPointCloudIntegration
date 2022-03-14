import UIKit
import RxSwift
import RxMVVM
import RxDataSources

class LiveViewController: ViewController<LiveViewModel> {
    
    @IBOutlet weak var liveItemsCollectionView: UICollectionView!
    
    private let liveItemsDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, LiveItemViewModel>> = CollectionViewConnector.reloadDataSource(LiveItemCollectionViewCell.self)
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Live"
        
        CollectionViewConnector.register(LiveItemCollectionViewCell.self,
                                         for: liveItemsCollectionView)
        
        let collectionViewLayout = liveItemsCollectionView.getLayout(ofType: GridCollectionViewFlowLayout.self)
        collectionViewLayout.horizontalItemsSpacing = 1
        collectionViewLayout.verticalItemsSpacing = 1
        collectionViewLayout.itemsPerLine = 2
    }
    
    override func bind(viewModel: ViewController<LiveViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        viewModel.liveItemSections
            .bind(to: liveItemsCollectionView.rx.items(dataSource: liveItemsDataSource))
            .disposed(by: disposeBag)
        
        liveItemsCollectionView.rx.modelSelected(LiveItemViewModel.self).bind(to: viewModel.liveItemSelected).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
