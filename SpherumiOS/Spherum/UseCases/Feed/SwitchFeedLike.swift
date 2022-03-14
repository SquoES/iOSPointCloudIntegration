import Foundation
import RxSwift
import CleanUseCase

class SwitchFeedLike: SingleUseCase<SwitchFeedLike.Input, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: SwitchFeedLike {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.feedRepository.switchLike(feedID: input.feedID)
    }
    
}

extension SwitchFeedLike {
    
    struct Input {
        let feedID: Int
    }
    
}
