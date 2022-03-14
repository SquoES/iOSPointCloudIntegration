import Foundation

struct LiveEvent: Codable {
    
    let id: Int?
    let views: Int?
    let is_liked: Bool?
    let preview: MediaFile?
    let created: String?
    let position: Int?
    let url: String?
    let title: String?
    let started_at: String?
    let status: String?
    let category: Int?
    let liked_by: [Int]?
    
}
