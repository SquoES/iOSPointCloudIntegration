import UIKit
import RxMVVM
import RxDataSources
import RxBiBinding

class ProfileViewController: ViewController<ProfileViewModel> {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var contentViewTypeSegmentedControl: BinarySegmentedControl!
    @IBOutlet weak var topContentViewTypeSegmentedControl: BinarySegmentedControl!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    
    private let imageCollectionDataSources: RxCollectionViewSectionedReloadDataSource<SectionModel<String, FeedElementItemViewModel>> = CollectionViewConnector.reloadDataSource(FeedElementItemCollectionViewCell.self)
    private let feedElementItemsDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, FeedElementItemViewModel>> = TableViewConnector.reloadTableViewDataSource(FeedElementItemTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.rx.setDelegate(self).disposed(by: disposeBag)
        contentCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        contentTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        CollectionViewConnector.register(FeedElementItemCollectionViewCell.self, for: contentCollectionView)
        TableViewConnector.register(FeedElementItemTableViewCell.self,
                                    for: contentTableView)
    }
    
    override func bind(viewModel: ViewController<ProfileViewModel>.ViewModel) {
                
        viewModel.feedElementItemViewSections
            .bind(to: contentTableView.rx.items(dataSource: feedElementItemsDataSource))
            .disposed(by: disposeBag)
        
        viewModel.feedElementItemViewSections
            .bind(to: contentCollectionView.rx.items(dataSource: imageCollectionDataSources))
            .disposed(by: disposeBag)
        
        contentTableView.rx.modelSelected(FeedElementItemViewModel.self).bind(to: viewModel.feedItemSelected).disposed(by: disposeBag)
        contentCollectionView.rx.modelSelected(FeedElementItemViewModel.self).bind(to: viewModel.feedItemSelected).disposed(by: disposeBag)
        
        viewModel.contentHeight.bind(onNext: { [unowned self] height in
            UIView.animate(withDuration: 0, delay: 0.1, options: .curveLinear, animations: {
                self.contentHeightConstraint.constant = height
            }, completion: nil)
        }).disposed(by: disposeBag)
        
        (contentViewTypeSegmentedControl.rx.selectedIndex <-> viewModel.typeContentViewIndex).disposed(by: disposeBag)
        (topContentViewTypeSegmentedControl.rx.selectedIndex <-> viewModel.typeContentViewIndex).disposed(by: disposeBag)
        
        viewModel.showCollectionView.bind(to: contentCollectionView.rx.isShown).disposed(by: disposeBag)
        viewModel.showTableView.bind(to: contentTableView.rx.isShown).disposed(by: disposeBag)
        
        //info
        rx.willAppear.bind(to: viewModel.willAppear).disposed(by: disposeBag)
        
        viewModel.firstName.bind(onNext: {[weak self] firstName in
            self?.navigationItem.title = firstName
        }).disposed(by: disposeBag)
        
        viewModel.profile.bind(to: headerView.rx.profile).disposed(by: disposeBag)
        viewModel.isMyProfile.bind(to: headerView.rx.isMe).disposed(by: disposeBag)
        
        headerView.rx.editProfile.bind(to: viewModel.editProfile).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === self.scrollView {
            let space = contentViewTypeSegmentedControl.convert(.zero, to: self.view).y - self.scrollView.frame.origin.y
            self.topContentViewTypeSegmentedControl.isHidden = space > 0
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 385
//    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width / 2 - 1, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
}
