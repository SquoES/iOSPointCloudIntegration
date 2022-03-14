import Foundation
import RxSwift
import CleanUseCase

class RefreshCategories: SingleUseCase<Void, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: RefreshCategories {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Void) -> Single<Void> {
        return self.feedRepository.refreshCategories()
    }
    
}
