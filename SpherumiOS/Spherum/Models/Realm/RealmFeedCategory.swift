


import Foundation
import RealmSwift

class RealmFeedCategory: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var isSubscribed: Bool = false
    @objc dynamic var followersCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
