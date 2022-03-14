import RxSwift

protocol LiveRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func refreshLiveEvents(page: Int?) -> Single<Void>
    
    func observeLiveEvents() -> Observable<[RealmLiveEvent]>
    
}
