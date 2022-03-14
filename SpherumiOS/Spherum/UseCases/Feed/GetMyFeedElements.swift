import Foundation
import RxSwift
import RealmSwift
import CleanUseCase

class GetMyFeedElements: ObservableUseCase<Void, GetMyFeedElements.Output> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: GetMyFeedElements {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return self.feedRepository.getMyFeedElements().map(Output.init)
    }
    
}

extension GetMyFeedElements {
    
    struct Output {
        let realmFeedElements: [RealmFeedElement]
    }
    
}
