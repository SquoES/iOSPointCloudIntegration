import Foundation
import CleanMapper
import RxSwift

class ProfileRepository: ProfileRepositoryProtocol {
    
    func refreshMyProfile() -> Single<Void> {
        self.request(ApiRouter.me, method: .get).map(processRefreshMyProfile)
    }
    
    func getMyProfile() -> Observable<RealmUserRetrieve?> {
        return self.observableCollection(type: RealmUserRetrieve.self,
                                         from: .myProfile).map({ $0.first })
    }
    
    func refreshProfile(userID: Int) -> Single<Void> {
        self.request(ApiRouter.profile(userID: userID), method: .get)
            .map(processRefreshProfile)
    }
    
    func getProfile(userID: Int) -> Observable<RealmUserRetrieve?> {
        return self.observableElementById(RealmUserRetrieve.self, id: userID, from: .users)
    }
    
    func updateProfile(fullname: String?, avatarID: Int?, about: String?) -> Single<Void> {
        
        var json: [String: Any] = [:]
        
        if let fullname = fullname {
            json["fullname"] = fullname
        }
        
        if let avatarID = avatarID {
            json["avatar"] = avatarID
        }
        
        if let about = about {
            json["about"] = about
        }
        
        return self.request(ApiRouter.editProfile, method: .patch, json: json)
    }
    
    
}

fileprivate extension ProfileRepository {
    
    func processRefreshMyProfile(_ profile: UserRetrieve) {
        let realmProfile: RealmUserRetrieve = Mapper.map(profile)
        
        UserPropertiesManager.instance.userID = profile.id
        
        self.store(singleValue: realmProfile, in: .myProfile)
    }
    
    func processRefreshProfile(_ profile: UserRetrieve) {
        let realmProfile: RealmUserRetrieve = Mapper.map(profile)
        
        self.store(singleValue: realmProfile, in: .users)
    }
    
}
