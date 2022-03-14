import Foundation
import RxAlamofireWrapper

class ApplicationState: NSObject {
    
    static let shared = ApplicationState()
    
    private override init() {
        super.init()
    }
    
    var isUserAuthorized: Bool {
        return !(AccessTokenStorage.accessToken?.isEmpty ?? true)
    }
    
}
