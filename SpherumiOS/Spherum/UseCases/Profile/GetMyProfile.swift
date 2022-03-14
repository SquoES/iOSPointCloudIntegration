import Foundation
import RxSwift
import CleanUseCase

class GetMyProfile: ObservableUseCase<Void, GetMyProfile.Output> {
    
    private var profileRepository: ProfileRepositoryProtocol!
    
    convenience init(profileRepository: ProfileRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.profileRepository = profileRepository
    }
    
    static var `default`: GetMyProfile {
        return .init(profileRepository: ProfileRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return self.profileRepository.getMyProfile().map(Output.init)
    }
    
    
}

extension GetMyProfile {
    
    struct Output {
        let profile: RealmUserRetrieve?
    }
    
}
