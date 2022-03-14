import RxMVVM

enum HomeRoute: NavigationRouteType {
    
    case home
    
    var storyboardName: String {
        "Home"
    }
    
    var navigationAction: NavigationAction {
        switch self {
        case .home:
            return .create(navigationType: .undefined) {
                let viewController = self.instantiateController(HomeViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: HomeViewModel())
                return NavigationController(rootViewController: viewController)
            }
        
        }
    }
    
}
