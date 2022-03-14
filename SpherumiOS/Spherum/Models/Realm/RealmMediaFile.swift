import Foundation
import RealmSwift

class RealmMediaFile: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var parentType: String = ""
    @objc dynamic var imgFile: String = ""
    @objc dynamic var sourceID: String = ""
    @objc dynamic var sourceURL: String = ""
    @objc dynamic var uploaded: Bool = false
    @objc dynamic var user: Int = 0
    
}
