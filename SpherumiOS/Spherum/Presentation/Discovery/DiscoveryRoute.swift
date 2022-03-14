import RxMVVM

enum DiscoveryRoute: NavigationRouteType {
    
    case discovery
    case feeds(userID: Int?, category: FeedCategory?)
    
    var storyboardName: String {
        "Discovery"
    }
    
    var navigationAction: NavigationAction {
        switch self {
        case .discovery:
            return .create(navigationType: .undefined) {
                let viewController = self.instantiateController(
                    DicsoveryViewController.self,
                    storyboardName: storyboardName,
                    viewModel: DicsoveryViewModel()
                )
                return NavigationController(rootViewController: viewController)
            }
            
        case let .feeds(userID, category): return .create(navigationType: .push, {
            return self.instantiateController(FeedsViewController.self, storyboardName: storyboardName, viewModel: FeedsViewModel(userID: userID, category: category))
        })
        }
    }
    
}
