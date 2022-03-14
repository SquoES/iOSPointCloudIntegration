import RxSwift
import CleanUseCase

class SwitchSubscribedToUser: SingleUseCase<SwitchSubscribedToUser.Input, Void> {
    
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: SwitchSubscribedToUser {
        SwitchSubscribedToUser(usersRepository: UsersRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        usersRepository.switchSubscribedToUser(id: input.userID)
    }
    
}

extension SwitchSubscribedToUser {
    
    struct Input {
        let userID: Int
    }
    
}
