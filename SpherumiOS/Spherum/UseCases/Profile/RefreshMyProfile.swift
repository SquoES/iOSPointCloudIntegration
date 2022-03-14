import Foundation
import RxSwift
import CleanUseCase

class RefreshMyProfile: SingleUseCase<Void, Void> {
    
    private var profileRepository: ProfileRepositoryProtocol!
    
    convenience init(profileRepository: ProfileRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.profileRepository = profileRepository
    }
    
    static var `default`: RefreshMyProfile {
        return .init(profileRepository: ProfileRepository())
    }
    
    override func createUseCase(input: Void) -> Single<Void> {
        return self.profileRepository.refreshMyProfile()
    }
    
    
}

