import Foundation
import RxSwift
import RealmSwift
import CleanUseCase

class GetFeedElements: ObservableUseCase<GetFeedElements.Input, GetFeedElements.Output> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: GetFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        return self.feedRepository.getFeedElements(userID: input.userID).map(Output.init)
    }
    
}

extension GetFeedElements {
    
    struct Input {
        let userID: Int?
    }
    
    struct Output {
        let realmFeedElements: [RealmFeedElement]
    }
    
}
