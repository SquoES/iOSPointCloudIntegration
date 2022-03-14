import Foundation
import RxSwift
import RealmSwift
import CleanUseCase

class GetFilteredFeedElements: ObservableUseCase<GetFilteredFeedElements.Input, GetFilteredFeedElements.Output> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: GetFilteredFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        return self.feedRepository.getFeedElements(categoryID: input.categoryID, userID: input.userID).map(Output.init)
    }
    
}

extension GetFilteredFeedElements {
    
    struct Input {
        let userID: Int?
        let categoryID: Int?
    }
    
    struct Output {
        let feedElement: [RealmFeedElement]
    }
    
}
