import RxMVVM

extension Navigator {
        
    static func dismiss() {
        self.navigate(route: DismissNavigationRoute())
    }
    
    static func pop() {
        self.navigate(route: PopNavigationRoute())
    }
    
}

private class DismissNavigationRoute: NavigationRouteType {
    
    var navigationAction: NavigationAction {
        .dismiss()
    }
    
}

private class PopNavigationRoute: NavigationRouteType {
    
    var navigationAction: NavigationAction {
        .pop()
    }
    
}
