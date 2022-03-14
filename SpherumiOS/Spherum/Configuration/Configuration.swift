import Foundation
import UIKit

protocol Configuration {
    
    static func setup()
    
}

extension Configuration {
    
    static var application: UIApplication {
        return .shared
    }
    
    static var appDelegate: AppDelegate {
        return application.delegate as! AppDelegate
    }
    
}

func APPLY_CONFIGURATIONS(_ configurations: Configuration.Type...) {
    for configuration in configurations {
        configuration.setup()
    }
}
