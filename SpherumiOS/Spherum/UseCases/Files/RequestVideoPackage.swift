import RxSwift
import CleanUseCase

class RequestVideoPackage: ObservableUseCase<RequestVideoPackage.Input, RequestVideoPackage.Output> {
    
    private let filesRepository: FilesRepositoryProtocol
    
    init(filesRepository: FilesRepositoryProtocol) {
        self.filesRepository = filesRepository
        super.init(executionSchedule: MainScheduler.asyncInstance,
                   resultSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: RequestVideoPackage {
        RequestVideoPackage(filesRepository: FilesRepository())
    }
    
    override func createUseCase(input: Input) -> Observable<Output> {
        filesRepository.downloadPackage(realmMediaFile: input.realmMediaFile)
            .map(Output.init)
    }
    
}

extension RequestVideoPackage {
    
    struct Input {
        let realmMediaFile: RealmMediaFile
    }
    
    struct Output {
        let videoPackageProgress: VideoPackageProgress
    }
    
}
