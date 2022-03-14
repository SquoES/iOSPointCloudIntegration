import Foundation

struct UserRetrieve: Codable {
 
    let id: Int?
    let fullname: String?
    let last_name: String?
    let email: String?
    let avatar: MediaFile?
    let about: String?
    let username: String?
    let is_subscribed: Bool?
    let followings_count: Int?
    let followers_count: Int?
    let feed_elements_count: Int?
    
}

extension UserRetrieve: Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserRetrieve, rhs: UserRetrieve) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
}
