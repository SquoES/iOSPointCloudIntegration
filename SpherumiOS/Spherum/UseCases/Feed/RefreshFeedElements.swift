import Foundation
import RxSwift
import CleanUseCase

class RefreshFeedElements: SingleUseCase<RefreshFeedElements.Input, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: RefreshFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.feedRepository.refreshFeedElements(page: input.page, userID: input.userID)
    }
    
}

extension RefreshFeedElements {
    
    struct Input {
        let page: Int?
        let userID: Int?
    }
    
}
