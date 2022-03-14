import RxSwift
import CleanMapper

class LiveRepository: LiveRepositoryProtocol {
    
    func refreshLiveEvents(page: Int?) -> Single<Void> {
        var json: [String: Any]? = nil
        
        if let offset = page {
            json?[JSONFieldConstants.offset] = offset
        }
        
        return self.request(ApiRouter.liveEvents,
                            method: .get,
                            json: json).debug().map(processRefreshLiveEvents)
    }
    
    func observeLiveEvents() -> Observable<[RealmLiveEvent]> {
        observableCollection(type: RealmLiveEvent.self,
                             from: .live)
    }
    
}

fileprivate extension LiveRepository {
    
    func processRefreshLiveEvents(_ liveEvents: PageElements<LiveEvent>) {
        let realmLiveEvents: [RealmLiveEvent] = Mapper.map(liveEvents.results)
        
        store(values: realmLiveEvents, in: .live)
    }
    
}
