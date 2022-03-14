import RealmSwift

class RealmLiveEvent: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var views: Int = 0
    @objc dynamic var isLiked: Bool = false
    @objc dynamic var preview: RealmMediaFile?
    @objc dynamic var created: String = ""
    @objc dynamic var position: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var startedAt: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var category: Int = 0
    let likedBy = List<Int>()
    
    override class func primaryKey() -> String? {
        "id"
    }
    
}
