import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    func keyboardHeight(safeAreaActive: Bool = true,
                        insetOnClose: CGFloat? = nil) -> Observable<CGFloat> {
        
        let defaultValue = insetOnClose ?? .zero
        
        let openedHeight: Observable<CGFloat> = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification).map {
                guard let frame = $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return defaultValue
                }
                
                let bottomSafeAreaInset = base.view.safeAreaInsets.bottom
                
                return frame.height.isZero
                    ? defaultValue
                    : frame.height - bottomSafeAreaInset
            }
        
        let closedHeight: Observable<CGFloat> = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification).map { _ in
                defaultValue
            }
        
        return Observable.merge(
            openedHeight,
            closedHeight
        )
        
    }
    
}
