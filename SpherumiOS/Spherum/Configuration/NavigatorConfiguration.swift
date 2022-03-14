import Foundation
import RxMVVM

class NavigatorConfiguration: Configuration {
    
    static func setup() {
        let navigationRoute: NavigationRouteType = ApplicationState.shared.isUserAuthorized ? MainRoute.tabBar : AuthorizationRoute.launchFuture
//        let navigationRoute: NavigationRouteType = MainRoute.tabBar
        Navigator.set(window: &appDelegate.window, route: navigationRoute)
    }
    
}
