import Foundation
import RxSwift
import CleanUseCase

class PasswordRecoveryRequest: SingleUseCase<PasswordRecoveryRequest.Input, Void> {
    
    private var authorizationRepository: AuthorizationRepositoryProtocol!
    
    convenience init(authorizationRepository: AuthorizationRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.authorizationRepository = authorizationRepository
    }
    
    static var `default`: PasswordRecoveryRequest {
        return .init(authorizationRepository: AuthorizationRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.authorizationRepository.passwordRecovery(email: input.email)
    }
    
    
}

extension PasswordRecoveryRequest {
    
    struct Input {
        let email: String
    }
    
}
