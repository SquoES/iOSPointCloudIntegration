import Foundation
import RxCocoa

extension BehaviorRelay where Element == Bool {
    
    func toggle() {
        self.accept(!self.value)
    }
    
    
}
