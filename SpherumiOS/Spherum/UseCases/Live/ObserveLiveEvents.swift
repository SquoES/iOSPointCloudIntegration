import RxSwift
import CleanUseCase

class ObserveLiveEvents: ObservableUseCase<Void, ObserveLiveEvents.Output> {
    
    private let liveRepository: LiveRepositoryProtocol

    init(liveRepository: LiveRepositoryProtocol) {
        self.liveRepository = liveRepository
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: ObserveLiveEvents {
        ObserveLiveEvents(liveRepository: LiveRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        liveRepository.observeLiveEvents().map(Output.init)
    }
    
}

extension ObserveLiveEvents {
    
    struct Output {
        let realmLiveEvents: [RealmLiveEvent]
    }
    
}
