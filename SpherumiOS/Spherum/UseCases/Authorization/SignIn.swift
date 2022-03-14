import Foundation
import RxSwift
import CleanUseCase

class SignIn: SingleUseCase<SignIn.Input, Void> {
    
    private var authorizationRepository: AuthorizationRepositoryProtocol!
    private let registerCurrentDevice: RegisterCurrentDevice
    
    init(authorizationRepository: AuthorizationRepositoryProtocol,
         deviceRepository: DeviceRepositoryProtocol) {
        
        self.authorizationRepository = authorizationRepository
        self.registerCurrentDevice = RegisterCurrentDevice(deviceRepository: deviceRepository)
        
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: SignIn {
        return .init(authorizationRepository: AuthorizationRepository(),
                     deviceRepository: DeviceRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.signIn(input: input)
            .flatMap {
                self.registerCurrentDevice.use().catchErrorJustReturn(())
            }
    }
    
    private func signIn(input: Input) -> Single<Void> {
        switch input {
        case .credentials(let username, let password):
            return self.authorizationRepository.login(username: username,
                                                      password: password)
        case .apple(let code, let firstName, let lastName):
            return self.authorizationRepository.appleSignIn(code: code,
                                                            firstName: firstName,
                                                            lastName: lastName)
        }
    }
    
    
}

extension SignIn {
    
    enum Input {
        case credentials(username: String, password: String)
        case apple(code: String, firstName: String?, lastName: String?)
    }
    
}
