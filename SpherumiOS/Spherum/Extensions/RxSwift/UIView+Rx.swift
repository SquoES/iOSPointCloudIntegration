import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    var isShown: Binder<Bool> {
        return Binder(self.base, binding: { view, isShown in
            view.isHidden = !isShown
        })
    }
    
    func isHidden(when neededValue: Bool) -> Binder<Bool> {
        return Binder(self.base, binding: { view, value in
            view.isHidden = neededValue == value
        })
    }
    
}
