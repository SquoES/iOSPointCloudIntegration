


import UIKit

extension UIRectCorner {
    
    mutating func set(_ rect: UIRectCorner, value: Bool) {
        _ = value ? self.insert(rect).memberAfterInsert : self.remove(rect)
    }
    
}
