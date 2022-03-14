import RxSwift

protocol UsersRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func isSubscribedToUser(id: Int) -> Observable<Bool>
    func switchSubscribedToUser(id: Int) -> Single<Void>
    
    func getUser(byID id: Int) -> Observable<RealmUserRetrieve?>
    
}
