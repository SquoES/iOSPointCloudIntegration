

import Foundation
import RealmSwift

class RealmFeedElement: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var views: Int = 0
    @objc dynamic var isLiked: Bool = false
    @objc dynamic var user: RealmUserRetrieve?
    @objc dynamic var preview: RealmMediaFile?
    @objc dynamic var mediaFile: RealmMediaFile?
    @objc dynamic var mediaFileType: String = ""
    @objc dynamic var category: Int = 0
    @objc dynamic var created: String = ""
    @objc dynamic var modifield: String = ""
    
    let likedBy = List<Int>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
