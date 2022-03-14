import RxMVVM

enum HomeBlock: CellBlockProtocol {
    
    case feedItem(FeedElementItemViewModel)
    case videoItem(BunnyCDNVideoItemViewModel)
    case loading
    
    var cellIdentifier: String {
        switch self {
        case .feedItem:
            return FeedElementItemTableViewCell.cellIdentifier
            
        case .videoItem:
            return BunnyCDNVideoItemTableViewCell.cellIdentifier
            
        case .loading:
            return LoadingItemTableViewCell.cellIdentifier
        }
    }
    
    var cellViewModel: ViewModelProtocol {
        switch self {
        case let . feedItem(viewModel):
            return viewModel
            
        case let .videoItem(viewModel):
            return viewModel
            
        case .loading:
            return LoadingItemViewModel(loading: true)
        }
    }
    
    static var allCellIdentifier: [String] {
        [
            FeedElementItemTableViewCell.cellIdentifier,
            BunnyCDNVideoItemTableViewCell.cellIdentifier,
            LoadingItemTableViewCell.cellIdentifier
        ]
    }
    
}
