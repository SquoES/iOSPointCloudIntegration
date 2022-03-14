import Foundation

struct MediaFile: Codable {
    
    let id: Int?
    let parnet_type: ParentType?
    let img_file: String?
    let source_id: String?
    let source_url: String?
    let uploaded: Bool?
    let user: Int?
    
    var imgFileURL: URL? {
        return URL(string: img_file ?? "")
    }
    
}

extension MediaFile {
    
    enum ParentType: String, Codable {
        case GALLERY
        case RAW_VIDEO
        case DIRECTORY
        case VIDEO_2D
        case LIDAR
        case FACE_ID
    }
    
    enum FileType: String, Codable {
        case VIDEO_2D
        case LIDAR
        case FACE_ID
    }
    
}
