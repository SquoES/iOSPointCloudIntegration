import RxMVVM

enum LiveRoute: NavigationRouteType {
    
    case live
    
    var storyboardName: String {
        "Live"
    }
    
    var navigationAction: NavigationAction {
        switch self {
        case .live:
            return .create(navigationType: .undefined) {
                let viewController = self.instantiateController(LiveViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: LiveViewModel())
                return NavigationController(rootViewController: viewController)
            }
        
        }
    }
    
}
