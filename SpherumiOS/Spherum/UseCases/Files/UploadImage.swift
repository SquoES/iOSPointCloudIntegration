import Foundation
import RxSwift
import CleanUseCase

class UploadImage: SingleUseCase<UploadImage.Input, UploadImage.Output> {
    
    private var filesRepository: FilesRepositoryProtocol!
    
    convenience init(filesRepository: FilesRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.filesRepository = filesRepository
    }
    
    static var `default`: UploadImage {
        return .init(filesRepository: FilesRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Output> {
        return self.filesRepository.uploadImage(imageURL: input.fileURL).map(Output.init)
    }
    
    
}

extension UploadImage {
    
    struct Input {
        let fileURL: URL
    }
    
    struct Output {
        let file: MediaFile?
    }
    
}
