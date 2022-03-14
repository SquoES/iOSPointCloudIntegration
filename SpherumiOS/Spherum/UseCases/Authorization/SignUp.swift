import Foundation
import RxSwift
import CleanUseCase

class SignUp: SingleUseCase<SignUp.Input, Void> {
    
    private var authorizationRepository: AuthorizationRepositoryProtocol!
    private let registerCurrentDevice: RegisterCurrentDevice
    
    init(authorizationRepository: AuthorizationRepositoryProtocol,
         deviceRepository: DeviceRepositoryProtocol) {
        
        self.authorizationRepository = authorizationRepository
        self.registerCurrentDevice = RegisterCurrentDevice(deviceRepository: deviceRepository)
        
        super.init(executionSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: SignUp {
        return .init(authorizationRepository: AuthorizationRepository(),
                     deviceRepository: DeviceRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.authorizationRepository.registration(firstName: input.firstName,
                                                         userName: input.userName,
                                                         email: input.email,
                                                         password: input.password,
                                                         rePassword: input.rePassword)
            .flatMap({ self.authorizationRepository.login(username: input.email, password: input.password) })
            .flatMap({ self.registerCurrentDevice.use().catchErrorJustReturn(()) })
    }
    
    
}

extension SignUp {
    
    struct Input {
        let firstName: String
        let userName: String
        let email: String
        let password: String
        let rePassword: String
    }
    
}
