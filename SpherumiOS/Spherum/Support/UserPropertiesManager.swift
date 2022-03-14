import Foundation

class UserPropertiesManager {
    
    public static let instance = UserPropertiesManager()
    
    private init(){}
    
    var userID: Int? {
        get { UserDefaults.standard.value(forKey: Key.userID.rawValue) as? Int}
        set { UserDefaults.standard.setValue(newValue, forKey: Key.userID.rawValue)}
    }
    
}

fileprivate extension UserPropertiesManager {
    
    enum Key: String {
        case userID
    }
    
}
