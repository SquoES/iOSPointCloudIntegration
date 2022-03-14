import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: NSLayoutConstraint {
    
    func animateConstant(withDuration duration: TimeInterval = 0.3) -> Binder<CGFloat> {
        .init(self.base) { constraint, newConstant in
            
            let superview = (constraint.firstItem as? UIView ?? constraint.secondItem as? UIView)?.superview
            
            UIView.animate(withDuration: duration) {
                constraint.constant = newConstant
                superview?.setNeedsLayout()
                superview?.layoutIfNeeded()
            }
        }
    }
    
}
