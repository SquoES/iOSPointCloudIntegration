import Foundation
import RxSwift

protocol ProfileRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func refreshMyProfile() -> Single<Void>
    func getMyProfile() -> Observable<RealmUserRetrieve?>
    
    func refreshProfile(userID: Int) -> Single<Void>
    func getProfile(userID: Int) -> Observable<RealmUserRetrieve?>
    
    func updateProfile(fullname: String?, avatarID: Int?, about: String?) -> Single<Void>
    
}
