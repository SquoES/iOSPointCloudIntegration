import Foundation
import RealmSwift

class RealmUserRetrieve: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var fullName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var avatar: RealmMediaFile?
    @objc dynamic var about: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var isSubscribed: Bool = false
    @objc dynamic var followingsCount: Int = 0
    @objc dynamic var followersCount: Int = 0
    @objc dynamic var feedElementsCount: Int = 0
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

