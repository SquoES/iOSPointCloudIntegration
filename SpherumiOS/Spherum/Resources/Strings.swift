import Foundation

extension String {
    
    static func custom(_ custom: Custom) -> String {
        return custom.rawValue
    }
    
    enum Custom: String {
        
        case noConnectionToTheInternet = "No connection"
        case serverUnavailable = "Server is not avaliable"
    }
    
}
