import Foundation
import RxSwift
import CleanUseCase

class EditProfile: SingleUseCase<EditProfile.Input, Void> {
    
    private var profileRepository: ProfileRepositoryProtocol!
    
    convenience init(profileRepository: ProfileRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.profileRepository = profileRepository
    }
    
    static var `default`: EditProfile {
        return .init(profileRepository: ProfileRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return self.profileRepository.updateProfile(fullname: input.fullname,
                                                    avatarID: input.avatarID,
                                                    about: input.about)
    }
    
    
}

extension EditProfile {
    
    struct Input {
        let fullname: String?
        let avatarID: Int?
        let about: String?
    }
    
    
}
