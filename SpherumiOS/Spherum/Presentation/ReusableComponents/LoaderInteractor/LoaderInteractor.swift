import UIKit

class LoaderInteractor: NSObject {
    
    private let loaderView = LoaderView()
    
    private weak var superview: UIView?
    
    init(superview: UIView) {
        self.superview = superview
    }
    
    func set(loading: Bool) {
        if loading {
            if loaderView.superview == nil, let superview = superview {
                loaderView.add(to: superview)
            }
        } else {
            loaderView.removeFromSuperview()
        }
    }
    
}
