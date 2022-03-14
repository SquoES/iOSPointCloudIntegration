

import Foundation

struct FeedElement: Codable {
    
    let id: Int?
    let views: Int?
    let is_liked: Bool?
    let user: UserRetrieve?
    let preview: MediaFile?
    let mediafile: MediaFile?
    let mediafile_type: MediaFile.FileType?
    let category: Int?
    let liked_by: [Int]
    
    ///format:
    let created: String?
    
    ///format:
    let modifield: String?
    
}
