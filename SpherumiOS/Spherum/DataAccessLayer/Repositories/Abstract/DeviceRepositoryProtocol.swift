import RxSwift

protocol DeviceRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func registerDevice(fcmToken: String) -> Single<Void>
    
}
