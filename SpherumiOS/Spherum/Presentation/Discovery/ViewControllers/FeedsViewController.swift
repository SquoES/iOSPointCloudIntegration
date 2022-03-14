import UIKit
import RxSwift
import RxMVVM
import RxDataSources

class FeedsViewController: ViewController<FeedsViewModel> {
    
    @IBOutlet weak var feedElementsTableView: UITableView!
    @IBOutlet weak var followButton: Button!
    @IBOutlet weak var followersLabel: UILabel!
    
    private let feedElementItemsDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, FeedElementItemViewModel>> = TableViewConnector.reloadTableViewDataSource(FeedElementItemTableViewCell.self)
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        
        TableViewConnector.register(FeedElementItemTableViewCell.self,
                                    for: feedElementsTableView)
        
        super.viewDidLoad()
    }
    
    override func bind(viewModel: ViewController<FeedsViewModel>.ViewModel) {
        
        viewModel.title.bind(onNext: {[weak self] in self?.title = $0}).disposed(by: disposeBag)
        viewModel.followers.bind(to: followersLabel.rx.text).disposed(by: disposeBag)
        viewModel.isSubscribed.bind(to: followButton.rx.isSelected).disposed(by: disposeBag)
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        viewModel.feedElementItemViewSections
            .bind(to: feedElementsTableView.rx.items(dataSource: feedElementItemsDataSource))
            .disposed(by: disposeBag)
        feedElementsTableView.rx.modelSelected(FeedElementItemViewModel.self)
            .bind(to: viewModel.feedItemSelected)
            .disposed(by: disposeBag)
        
        followButton.rx.tap.bind(to: viewModel.switchSubscribe).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
