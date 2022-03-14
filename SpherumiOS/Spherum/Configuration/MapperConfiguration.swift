import Foundation
import CleanMapper
import SwiftyJSON
import RealmSwift

class MapperConfiguration: Configuration {
    
    static func setup() {
        
        //MARK: - Profile to RealmProfile
        Mapper.register(mappingAlgorithm: { (profile: Profile) -> RealmProfile in
            let realmProfile = RealmProfile()
            
            realmProfile.id = profile.id
            realmProfile.firstName = profile.firstName
            realmProfile.lastName = profile.lastName
            realmProfile.email = profile.email
            realmProfile.avatar = profile.avatar?.absoluteString
            realmProfile.about = profile.about
            realmProfile.followersCount = profile.followersCount
            realmProfile.followingsCount = profile.followingsCount
            
            
            return realmProfile
        })
        
        //MARK: RealmProfile to Profile
        Mapper.register(mappingAlgorithm: { (realmProfile: RealmProfile) -> Profile in
            return Profile(
                id: realmProfile.id,
                firstName: realmProfile.firstName,
                lastName: realmProfile.lastName,
                email: realmProfile.email,
                avatar: realmProfile.avatar?.url,
                about: realmProfile.about,
                followersCount: realmProfile.followersCount,
                followingsCount: realmProfile.followingsCount
            )
        })
        
        //MARK: - FeedCategory to RealmCategory
        Mapper.register(mappingAlgorithm: { (target: FeedCategory) -> RealmFeedCategory in
            let result = RealmFeedCategory()
            
            result.id = target.id ?? 0
            result.title = target.title ?? ""
            result.isSubscribed = target.is_subscribed ?? false
            result.followersCount = target.followers_count ?? 0
                        
            return result
        })
        
        //MARK: RealmFeedCategory to FeedCategory
        Mapper.register(mappingAlgorithm: {(target: RealmFeedCategory) -> FeedCategory in
            return FeedCategory(id: target.id, title: target.title, is_subscribed: target.isSubscribed, followers_count: target.followersCount)
        })
        
        //MARK: - FeedElement to RealmFeedElement
        Mapper.register(mappingAlgorithm: { (targer: FeedElement) -> RealmFeedElement in
            let result = RealmFeedElement()
            
            result.id = targer.id ?? 0
            result.views = targer.views ?? 0
            result.user = optionalMap(targer.user)
            result.preview = optionalMap(targer.preview)
            result.mediaFile = optionalMap(targer.mediafile)
            result.mediaFileType = targer.mediafile_type?.rawValue ?? ""
            result.category = targer.category ?? 0
            result.created = targer.created ?? ""
            result.modifield = targer.modifield ?? ""
            result.views = targer.views ?? 0
            result.isLiked = targer.is_liked ?? false
            
            result.likedBy.append(objectsIn: targer.liked_by)
            
            return result
        })
        
        //MARK: RealmFeedElement to FeedElement
        Mapper.register(mappingAlgorithm: {(target: RealmFeedElement) -> FeedElement in
            return FeedElement(id: target.id,
                               views: target.views,
                               is_liked: target.isLiked,
                               user: optionalMap(target.user),
                               preview: optionalMap(target.preview),
                               mediafile: optionalMap(target.mediaFile),
                               mediafile_type: .init(rawValue: target.mediaFileType),
                               category: target.category,
                               liked_by: target.likedBy.toArray(),
                               created: target.created,
                               modifield: target.modifield)
        })
        
        //MARK: - UserRetrieve to RealmUserRetrieve
        Mapper.register(mappingAlgorithm: {(target: UserRetrieve) -> RealmUserRetrieve in
            let result = RealmUserRetrieve()
            
            result.id = target.id ?? 0
            result.fullName = target.fullname ?? ""
            result.lastName = target.last_name ?? ""
            result.email = target.email ?? ""
            result.avatar = optionalMap(target.avatar)
            result.about = target.about ?? ""
            result.username = target.username ?? ""
            result.isSubscribed = target.is_subscribed ?? false
            result.followersCount = target.followers_count ?? 0
            result.followingsCount = target.followings_count ?? 0
            result.feedElementsCount = target.feed_elements_count ?? 0
            
            return result
        })
        
        //MARK: RealmUserRetrieve to UserRetrieve
        Mapper.register(mappingAlgorithm: {(target: RealmUserRetrieve) -> UserRetrieve in
            
            return UserRetrieve(id: target.id,
                                fullname: target.fullName,
                                last_name: target.lastName,
                                email: target.email,
                                avatar: optionalMap(target.avatar),
                                about: target.about,
                                username: target.username,
                                is_subscribed: target.isSubscribed,
                                followings_count: target.followingsCount,
                                followers_count: target.followersCount,
                                feed_elements_count: target.feedElementsCount)
        })
        
        //MARK: - MediaFile to RealmMediaFile
        Mapper.register(mappingAlgorithm: {(target: MediaFile) -> RealmMediaFile in
            let result = RealmMediaFile()
            
            result.id = target.id ?? 0
            result.parentType = target.parnet_type?.rawValue ?? ""
            result.imgFile = target.img_file ?? ""
            result.sourceID = target.source_id ?? ""
            result.sourceURL = target.source_url ?? ""
            result.uploaded = target.uploaded ?? false
            result.user = target.user ?? 0
            
            return result
        })
        
        //MARK: RealmMediaFile to MeidaFile
        Mapper.register(mappingAlgorithm: {(target: RealmMediaFile) -> MediaFile in
            return MediaFile(id: target.id,
                             parnet_type: .init(rawValue: target.parentType),
                             img_file: target.imgFile,
                             source_id: target.sourceID,
                             source_url: target.sourceURL,
                             uploaded: target.uploaded,
                             user: target.user)
        })
        
        // MARK: - LiveEvent to RealmLiveEvent
        Mapper.register(mappingAlgorithm: { (target: LiveEvent) -> RealmLiveEvent in
            let result = RealmLiveEvent()
            result.id = target.id ?? 0
            result.views = target.views ?? 0
            result.isLiked = target.is_liked ?? false
            result.preview = optionalMap(target.preview)
            result.created = target.created ?? ""
            result.position = target.position ?? 0
            result.url = target.url ?? ""
            result.title = target.title ?? ""
            result.startedAt = target.started_at ?? ""
            result.status = target.status ?? ""
            result.category = target.category ?? 0
            result.likedBy.append(objectsIn: target.liked_by ?? [])
            return result
        })
        
        // MARK: RealmLiveEvent to LiveEvent
        Mapper.register(mappingAlgorithm: { (target: RealmLiveEvent) -> LiveEvent in
            LiveEvent(id: target.id,
                      views: target.views,
                      is_liked: target.isLiked,
                      preview: optionalMap(target.preview),
                      created: target.created,
                      position: target.position,
                      url: target.url,
                      title: target.title,
                      started_at: target.startedAt,
                      status: target.status,
                      category: target.category,
                      liked_by: target.likedBy.toArray())
        })
        
    }
    
    private static func optionalMap<Target, Result>(_ target: Target?) -> Result? {
        guard let target = target else {
            return nil
        }
        
        let result: Result = Mapper.map(target)
        return result
    }
    
}
