import RxSwift
import CleanUseCase

class IsSubscribedToUser: ObservableUseCase<IsSubscribedToUser.Input, IsSubscribedToUser.Output> {
    
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: IsSubscribedToUser {
        IsSubscribedToUser(usersRepository: UsersRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        usersRepository.isSubscribedToUser(id: input.userID)
            .map(Output.init)
    }
    
}

extension IsSubscribedToUser {
    
    struct Input {
        let userID: Int
    }
    
    struct Output {
        let subscribed: Bool
    }
    
}
