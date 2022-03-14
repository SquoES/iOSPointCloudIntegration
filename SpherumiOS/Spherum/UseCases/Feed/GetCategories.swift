import Foundation
import RxSwift
import CleanUseCase

class GetCategories: ObservableUseCase<Void, GetCategories.Output> {
    
    private var feedRepository: FeedRepositoryProtocol!
    
    convenience init(feedRepository: FeedRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.feedRepository = feedRepository
    }
    
    static var `default`: GetCategories {
        return .init(feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return self.feedRepository.getCategories().map(Output.init)
    }
    
}

extension GetCategories {
    
    struct Output {
        let categories: [FeedCategory]
    }
    
}
