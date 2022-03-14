import Foundation
import RxSwift
import CleanUseCase

class SwitchCategorySubscribe: SingleUseCase<SwitchCategorySubscribe.Input, Void> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: SwitchCategorySubscribe {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.feedRepository.switchCategorySubscribe(categoryID: input.categoryID)
    }
    
}

extension SwitchCategorySubscribe {
    
    struct Input {
        let categoryID: Int
    }
    
}
