import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyle()
    }
    
    private func setupNavigationBarStyle() {
        
        navigationBar.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationBar.shadowImage = UIImage()
        
        navigationBar.backIndicatorImage = .navigationBackArrow
        navigationBar.backIndicatorTransitionMaskImage = .navigationBackArrow
        
        navigationBar.tintColor = .black100
        
        navigationBar.titleTextAttributes = [
            .font: UIFont.gilroyFont(ofSize: 22, weight: .semibold)!,
            .foregroundColor: UIColor.appBlackColor
        ]
        
    }
    
    func applyDarkStyle() {
        navigationBar.backIndicatorImage = .navigationBackArrow?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        navigationBar.tintColor = .white
    }
    
    func applyLightStyle() {
        navigationBar.backIndicatorImage = .navigationBackArrow
        navigationBar.tintColor = .black100
    }
    
}

extension UINavigationController {
    
    func asNavigationController() -> NavigationController? {
        return self as? NavigationController
    }
    
}
