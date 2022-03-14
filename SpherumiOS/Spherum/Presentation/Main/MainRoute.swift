import RxMVVM

enum MainRoute: NavigationRouteType {
    
    case tabBar
    
    var navigationAction: NavigationAction {
        switch self {
        case .tabBar:
            return .create(navigationType: .root) {
                return MainTabBarViewController()
            }
        
        }
    }
    
}
