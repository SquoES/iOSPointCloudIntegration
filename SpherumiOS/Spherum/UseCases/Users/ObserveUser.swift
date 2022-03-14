import RxSwift
import CleanUseCase

class ObserveUser: ObservableUseCase<ObserveUser.Input, ObserveUser.Output> {
    
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: ObserveUser {
        ObserveUser(usersRepository: UsersRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        usersRepository.getUser(byID: input.userID).map(Output.init)
    }
    
}

extension ObserveUser {
    
    struct Input {
        let userID: Int
    }
    
    struct Output {
        let user: RealmUserRetrieve?
    }
    
}
