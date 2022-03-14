import Foundation
import Alamofire

enum ApiRouter: URLConvertible {
    
    //MARK: Auth
    case login
    case users
    case passwordRecovery
    case acceptPasswordRecovery(uuid: String)
    case appleSignIn
    
    //MARK: Feed
    case categories
    case feeds
    case myFeed
    case likeFeed(feedID: Int)
    case subscribeCategory(categoryID: Int)
    
    //MARK: Profile
    case me
    case profile(userID: Int)
    case editProfile
    
    //MARK: Files
    case files
    case file(fileID: Int)
    
    // MARK: Users
    case switchSubscribeToUser(id: Int)
    
    // MARK: Live
    case liveEvents
    
    // MARK: Files
    case createPresignURL
    case confirmFileUpload(mediaFileID: String)
    case confirmUpload(id: String)
    
    // MARK: Devices
    case devices
    
    var resourcePath: String {
        switch self {
        
        //MARK: - Auth
        case .login: return "get_token/"
        case .users:  return "users/"
            
        case .passwordRecovery: return "password_change_orders/"
        case let .acceptPasswordRecovery(uuid): return "/password_change_orders/\(uuid)/activate/"
            
        case .appleSignIn: return "apple_auth/"
            
        //MARK: - Feed
        case .categories: return "categories/"
        case .feeds: return "feed_elements/"
        case .myFeed: return "feed_elements/mine/"
        case let .likeFeed(feedID): return "/feed_elements/\(feedID)/switch_like/"
        case let .subscribeCategory(categoryID): return "/categories/\(categoryID)/switch_subscribe/"
            
        //MARK: - Profile
        case .me: return "users/me/"
        case let .profile(userID): return "users/\(userID)/"
        case .editProfile: return "users/edit/"
            
        //MARK: - Files
        case .files: return "media_files/"
        case let .file(fileID): return "media_files/\(fileID)/"
            
            // MARK: Users
        case let .switchSubscribeToUser(id):
            return "users/\(id)/switch_subscribe/"
            
        // MARK: Live Events
        case .liveEvents:
            return "live_events/"
            
        // MARK: Files
        case .createPresignURL:
            return "media_files/create_presign_url_post/"
        case let .confirmFileUpload(mediaFileID):
            return "media_files/\(mediaFileID)/confirm_upload/"
        case let .confirmUpload(id):
            return "media_files/\(id)/confirm_upload/"
            
        // MARK: Devices
        case .devices:
            return "devices/"
        }
    }
    
    func asURL() throws -> URL {
        return ApiConstants.apiBaseEndpoint.url!.appendingPathComponent(resourcePath)
    }
}
