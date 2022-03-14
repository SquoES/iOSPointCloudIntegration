import UIKit
import RxSwift
import RxMVVM
import RxDataSources

class HomeViewController: ViewController<HomeViewModel> {
    
    @IBOutlet weak var feedTabelView: UITableView!
    
    let feedDataSources: RxTableViewSectionedReloadDataSource<SectionModel<String, HomeBlock>> = TableViewConnector.reloadTableViewDataSource(HomeBlock.self)
    
    private let liveStreamHeaderView = LiveStreamHeaderView(frame: .zero)
    private let messagesButton = BadgedButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTitleView()
                
        TableViewConnector.register(HomeBlock.self,
                                    for: feedTabelView)
        
        feedTabelView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<HomeViewModel>.ViewModel) {
        
        viewModel.itemSections.bind(to: feedTabelView.rx.items(dataSource: feedDataSources)).disposed(by: disposeBag)
        feedTabelView.rx.modelSelected(HomeBlock.self).bind(to: viewModel.itemSelected).disposed(by: disposeBag)
        
        liveStreamHeaderView.segmentedControl.rx.selectedIndex.bind(to: viewModel.selectedTab).disposed(by: disposeBag)
                        
        super.bind(viewModel: viewModel)
    }
    
    private func updateTitleView() {
        let logoImageView = UIImageView(image: .headLogo)
        logoImageView.contentMode = .left
        
        let spaceView = UIView()
        let constraint = spaceView.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        messagesButton.setTitle(nil, for: .normal)
        messagesButton.setImage(.mesages_icon, for: .normal)
        messagesButton.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        //TODO: messagesButton - верменно убран из бара навигации
        let tileStackView = UIStackView(arrangedSubviews: [logoImageView, spaceView])
        self.navigationItem.titleView = tileStackView
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ?  self.liveStreamHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ?  276 : 0
    }
}
