import Foundation
import RxSwift
import RealmSwift
import CleanUseCase

class RefreshFilteredFeedElements: SingleUseCase<RefreshFilteredFeedElements.Input, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: RefreshFilteredFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.feedRepository.refreshFeedElements(offset: input.offset, categoryID: input.categoryID, userID: input.categoryID)
    }
    
}

extension RefreshFilteredFeedElements {
    
    struct Input {
        let offset: Int?
        let userID: Int?
        let categoryID: Int?
    }
    
}
