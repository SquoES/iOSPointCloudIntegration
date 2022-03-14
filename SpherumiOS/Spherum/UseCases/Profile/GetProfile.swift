import Foundation
import RxSwift
import CleanUseCase

class GetProfile: ObservableUseCase<GetProfile.Input, GetProfile.Output> {
    
    private var profileRepository: ProfileRepositoryProtocol!
    
    convenience init(profileRepository: ProfileRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.profileRepository = profileRepository
    }
    
    static var `default`: GetProfile {
        return .init(profileRepository: ProfileRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        return self.profileRepository.getProfile(userID: input.userID).map(Output.init)
    }
    
    
}

extension GetProfile {
    
    struct Input {
        let userID: Int
    }
    
    struct Output {
        let profile: RealmUserRetrieve?
    }
    
}
