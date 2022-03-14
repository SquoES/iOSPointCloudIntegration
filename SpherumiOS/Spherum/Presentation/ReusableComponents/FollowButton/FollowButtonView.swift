import UIKit
import RxSwift
import RxCocoa

class FollowButtonView: XibView {
    @IBOutlet private weak var buttonBackgroundView: UIView!
    @IBOutlet private weak var notFollowingView: UIView!
    @IBOutlet private weak var followingView: UIView!
    @IBOutlet weak var switchFollowingButton: UIButton!
    
    @IBInspectable var isFollowing: Bool = true {
        didSet {
            self.switchFollowing()
        }
    }
    
    private func switchFollowing() {
        displayStateSpecifiedViews()
        applyStateSpecifiedBackgroundColor()
    }
    
    private func displayStateSpecifiedViews() {
        followingView.isHidden = !isFollowing
        notFollowingView.isHidden = isFollowing
    }
    
    private func applyStateSpecifiedBackgroundColor() {
        if isFollowing {
            buttonBackgroundView.backgroundColor = .lightGrayColor
        } else {
            buttonBackgroundView.backgroundColor = .lightBlueColor
        }
    }
}

extension Reactive where Base: FollowButtonView {
    var isFollowing: Binder<Bool> {
        Binder(self.base) { view, isFollowing in
            view.isFollowing = isFollowing
        }
    }
    
    var switchFollowingButtonTap: ControlEvent<Void> {
        self.base.switchFollowingButton.rx.tap
    }
}
