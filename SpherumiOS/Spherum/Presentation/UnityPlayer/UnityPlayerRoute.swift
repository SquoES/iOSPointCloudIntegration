import RxMVVM

enum UnityPlayerRoute: NavigationRouteType {
    
    case player(videoGroup: BunnyCDNVideoGroup)
    
    var navigationAction: NavigationAction {
        switch self {
        case let .player(videoGroup):
            return .create(navigationType: .modal) {
                let viewModel = UnityPlayerViewModel(videoGroup: videoGroup)
                let viewController = UnityPlayerViewController()
                viewController.viewModel = viewModel
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationCapturesStatusBarAppearance = true
                return viewController
            }
        }
    }
    
}
