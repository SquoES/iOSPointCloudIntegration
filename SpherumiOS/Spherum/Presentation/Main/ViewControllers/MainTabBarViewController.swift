import UIKit
import RxMVVM

class MainTabBarViewController: UITabBarController,
                                UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarStyle()
        setupViewControllers()
        
        delegate = self
    }
    
    private func setupTabBarStyle() {
        tabBar.tintColor = .appBlackColor
        tabBar.unselectedItemTintColor = .unselectedLightGrayColor
        
        tabBar.backgroundColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    private func setupViewControllers() {
        let viewControllers: [UIViewController] = [
            viewController(forNavigationRoute: HomeRoute.home,
                           tabBarItem: .home),
            viewController(forNavigationRoute: DiscoveryRoute.discovery,
                           tabBarItem: .discovery),
            viewController(forNavigationRoute: nil,
                           tabBarItem: .add),
            viewController(forNavigationRoute: LiveRoute.live,
                           tabBarItem: .live),
            viewController(forNavigationRoute: ProfileRoute.myProfile,
                           tabBarItem: .profile)
        ]
        
        setViewControllers(viewControllers,
                           animated: false)
    }
    
    private func viewController(forNavigationRoute navigationRoute: NavigationRouteType!,
                                tabBarItem: TabBarItem) -> UIViewController {
        switch tabBarItem {
        case .add:
            let viewController = UIViewController()
            viewController.tabBarItem = tabBarItem.createUITabBarItem()
            return viewController
            
        default:
            let viewController = navigationRoute.navigationAction.destinationController!
            viewController.tabBarItem = tabBarItem.createUITabBarItem()
            return viewController
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let index = viewControllers?.firstIndex(of: viewController) {
            
            if index == 2 {
                Navigator.navigate(route: StoryRoute.addStory, completion: nil)
                return false
            }
            
        }
        
        return true
    }
    
}

private enum TabBarItem: CaseIterable {
    
    case home
    case discovery
    
    case add
    
    case live
    case profile
    
    private var iconImage: UIImage? {
        switch self {
        case .home:
            return .homeTabIcon?.withRenderingMode(.alwaysTemplate)
            
        case .discovery:
            return .discoveryTabIcon?.withRenderingMode(.alwaysTemplate)
            
        case .add:
            return .addTabIcon?.withRenderingMode(.alwaysOriginal)
            
        case .live:
            return .liveTabIcon?.withRenderingMode(.alwaysTemplate)
            
        case .profile:
            return .profileTabIcon?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    private var title: String? {
        switch self {
        case .home:
            return "Home"
            
        case .discovery:
            return "Discovery"
            
        case .add:
            return nil
            
        case .live:
            return "Live"
            
        case .profile:
            return "Profile"
        }
    }
    
    private var imageInsets: UIEdgeInsets {
        switch self {
        case .add:
            return .init(top: 6, left: 0, bottom: -6, right: 0)
            
        default:
            return .zero
        }
    }
    
    private var normalTextAttributes: [NSAttributedString.Key: Any] {
        [
            .font: UIFont.gilroyFont(ofSize: 10, weight: .semibold)!
        ]
    }
    
    private var selectedTextAttributes: [NSAttributedString.Key: Any] {
        [
            .font: UIFont.gilroyFont(ofSize: 10, weight: .semibold)!
        ]
    }
    
    func createUITabBarItem() -> UITabBarItem {
        let uiTabBarItem = UITabBarItem(title: title,
                                        image: iconImage,
                                        tag: 0)
        uiTabBarItem.setTitleTextAttributes(normalTextAttributes,
                                            for: .normal)
        uiTabBarItem.setTitleTextAttributes(selectedTextAttributes,
                                            for: .selected)
        uiTabBarItem.imageInsets = imageInsets
        return uiTabBarItem
    }
    
}
