import Foundation
import RxSwift
import CleanUseCase

class RefreshProfile: SingleUseCase<RefreshProfile.Input, Void> {
    
    private var profileRepository: ProfileRepositoryProtocol!
    
    convenience init(profileRepository: ProfileRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.profileRepository = profileRepository
    }
    
    static var `default`: RefreshProfile {
        return .init(profileRepository: ProfileRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.profileRepository.refreshProfile(userID: input.userID)
    }
    
    
}

extension RefreshProfile {
    
    struct Input {
        let userID: Int
    }
        
}
