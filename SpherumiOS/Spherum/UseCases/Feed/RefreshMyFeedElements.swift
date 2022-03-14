import Foundation
import RxSwift
import CleanUseCase

class RefreshMyFeedElements: SingleUseCase<RefreshMyFeedElements.Input, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: RefreshMyFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.feedRepository.refreshMyFeedElements(page: input.page)
    }
    
}

extension RefreshMyFeedElements {
    
    struct Input {
        let page: Int?
    }
    
}
