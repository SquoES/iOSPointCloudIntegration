import Foundation
import RealmSwift

class RealmProfile: Object {
    
    @objc dynamic var id: Int = .zero
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var avatar: String? = nil
    @objc dynamic var about: String? = nil
    @objc dynamic var followersCount: Int = .zero
    @objc dynamic var followingsCount: Int = .zero
    
    override class func primaryKey() -> String? {
        "id"
    }
    
}
