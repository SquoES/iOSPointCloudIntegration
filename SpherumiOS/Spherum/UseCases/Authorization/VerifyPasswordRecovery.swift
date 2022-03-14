import Foundation
import RxSwift
import CleanUseCase

class VerifyPasswordRecovery: SingleUseCase<VerifyPasswordRecovery.Input, Void> {
    
    private var authorizationRepository: AuthorizationRepositoryProtocol!
    
    convenience init(authorizationRepository: AuthorizationRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.authorizationRepository = authorizationRepository
    }
    
    static var `default`: VerifyPasswordRecovery {
        return .init(authorizationRepository: AuthorizationRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.authorizationRepository.verifyPasswordRecovery(uuid: input.uuid)
    }
    
    
}

extension VerifyPasswordRecovery {
    
    struct Input {
        let uuid: String
    }
    
}
