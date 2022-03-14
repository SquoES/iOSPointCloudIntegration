import RxSwift
import RxCocoa

extension Reactive where Base: PrepareVideoView {
    
    var close: ControlEvent<Void> {
        base.cancelButton.rx.tap
    }
    
}
