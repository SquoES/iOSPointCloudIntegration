import Foundation

extension Optional {
    
    var isNil: Bool {
        switch self {
        case .none:
            return true
            
        default:
            return false
        }
    }
    
    var isNotNil: Bool {
        switch self {
        case .some:
            return true
            
        default:
            return false
        }
    }
    
    static func isNil(_ optional: Self) -> Bool {
        return optional.isNil
    }
    
    static func isNotNil(_ optional: Self) -> Bool {
        return optional.isNotNil
    }
    
}
