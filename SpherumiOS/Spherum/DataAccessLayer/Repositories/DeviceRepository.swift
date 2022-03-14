import RxSwift

class DeviceRepository: DeviceRepositoryProtocol {
    
    func registerDevice(fcmToken: String) -> Single<Void> {
        let json: [String: Any] = [
            "registration_id": fcmToken,
            "type": "ios"
        ]
        
        return self.request(ApiRouter.devices,
                            method: .post,
                            json: json)
    }

}
