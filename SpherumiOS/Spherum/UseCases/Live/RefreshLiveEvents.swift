import RxSwift
import CleanUseCase

class RefreshLiveEvents: SingleUseCase<RefreshLiveEvents.Input, Void> {
    
    private let liveRepository: LiveRepositoryProtocol

    init(liveRepository: LiveRepositoryProtocol) {
        self.liveRepository = liveRepository
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: RefreshLiveEvents {
        RefreshLiveEvents(liveRepository: LiveRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        liveRepository.refreshLiveEvents(page: input.page)
    }
    
}

extension RefreshLiveEvents {
    
    struct Input {
        let page: Int?
    }
    
}
