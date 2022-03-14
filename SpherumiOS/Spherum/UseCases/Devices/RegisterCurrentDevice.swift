import RxSwift
import CleanUseCase
import FirebaseMessaging

class RegisterCurrentDevice: SingleUseCase<Void, Void> {
    
    private let deviceRepository: DeviceRepositoryProtocol
    
    init(deviceRepository: DeviceRepositoryProtocol) {
        self.deviceRepository = deviceRepository
    }
    
    static var `default`: RegisterCurrentDevice {
        RegisterCurrentDevice(deviceRepository: DeviceRepository())
    }
    
    override func createUseCase(input: Void) -> Single<Void> {
        self.getDeviceToken().flatMap { deviceToken in
            if let deviceToken = deviceToken {
                return self.deviceRepository.registerDevice(fcmToken: deviceToken)
            } else {
                return .just(())
            }
        }
    }
    
    private func getDeviceToken() -> Single<String?> {
        .deferred {
            FirebaseMessaging.Messaging.messaging().fcmToken
        }
    }
}
