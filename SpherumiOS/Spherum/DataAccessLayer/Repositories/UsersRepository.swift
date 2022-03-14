import RealmSwift
import RxSwift
import CleanMapper

class UsersRepository: UsersRepositoryProtocol {
    
    func isSubscribedToUser(id: Int) -> Observable<Bool> {
        observableElementById(RealmUserRetrieve.self,
                              id: id,
                              from: .users).map { $0?.isSubscribed ?? false }
    }
    
    func switchSubscribedToUser(id: Int) -> Single<Void> {
        request(ApiRouter.switchSubscribeToUser(id: id),
                method: .post).map(processSwitchSubscribedToUser(user:))
    }
    
    func getUser(byID id: Int) -> Observable<RealmUserRetrieve?> {
        observableElementById(RealmUserRetrieve.self,
                              id: id,
                              from: .users)
    }
    
}

fileprivate extension UsersRepository {
    
    func processSwitchSubscribedToUser(user: UserRetrieve) {
        let realmUser: RealmUserRetrieve = Mapper.map(user)
        store(value: realmUser, in: .users)
    }
    
}
