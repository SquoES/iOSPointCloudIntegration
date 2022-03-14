import Foundation
import UIKit

enum AlertItem: String {
    
    case cancel
    
    case yes
    case no
    
    case ok
    
    case takePhoto
    case openGallery
    
    var actionStyle: UIAlertAction.Style {
        switch self {
        case .cancel: return .cancel
        default: return .default
        }
    }
    
    var title: String {
        switch self {
        case .ok: return "Ok"
        case .cancel: return "Cancel"
        case .yes: return "Yes"
        case .no: return "No"
        case .takePhoto: return "Take photo"
        case .openGallery: return "Photo gallery"
        }
    }
    
    var backgroundColor: UIColor? { return nil}
    var titleColor: UIColor? { return nil }
    
    static func from(rawValue: String?) -> AlertItem {
        guard let rawValue = rawValue else {
            return .ok
        }
        return AlertItem(rawValue: rawValue) ?? .ok
    }
}
