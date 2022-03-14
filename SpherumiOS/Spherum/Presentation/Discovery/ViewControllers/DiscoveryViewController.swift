import UIKit
import RxSwift
import RxMVVM
import RxDataSources

class DicsoveryViewController: ViewController<DicsoveryViewModel> {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var feedElementsTableView: UITableView!
    
    private let categoryDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, CategoryItemViewModel>> = CollectionViewConnector.reloadDataSource(CategoryItemCollectionViewCell.self)
    private let feedElementItemsDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, FeedElementItemViewModel>> = TableViewConnector.reloadTableViewDataSource(FeedElementItemTableViewCell.self)
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        CollectionViewConnector.register(CategoryItemCollectionViewCell.self,
                                         for: categoryCollectionView)
        
        
        TableViewConnector.register(FeedElementItemTableViewCell.self,
                                    for: feedElementsTableView)
        
        self.navigationItem.title = "Discovery"
        
        super.viewDidLoad()
    }
    
    override func bind(viewModel: ViewController<DicsoveryViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        categoryCollectionView.rx
            .modelSelected(CategoryItemViewModel.self)
            .bind(to: viewModel.categorySelected)
            .disposed(by: disposeBag)
        viewModel.categoryItemViewSections
            .bind(to: categoryCollectionView.rx.items(dataSource: categoryDataSource))
            .disposed(by: disposeBag)
        
        viewModel.feedElementItemViewSections
            .bind(to: feedElementsTableView.rx.items(dataSource: feedElementItemsDataSource))
            .disposed(by: disposeBag)
        feedElementsTableView.rx.modelSelected(FeedElementItemViewModel.self)
            .bind(to: viewModel.feedItemSelected)
            .disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
