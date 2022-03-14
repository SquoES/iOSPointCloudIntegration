import RxSwift
import CleanUseCase

class PrepareAndUploadVideoPackage: SingleUseCase<PrepareAndUploadVideoPackage.Input, Void> {
    
    private let filesRepository: FilesRepositoryProtocol
    private let feedRepository: FeedRepositoryProtocol
    
    init(filesRepository: FilesRepositoryProtocol, feedRepository: FeedRepositoryProtocol) {
        self.filesRepository = filesRepository
        self.feedRepository = feedRepository
        super.init(executionSchedule: ConcurrentDispatchQueueScheduler(qos: .userInitiated),
                   resultSchedule: MainScheduler.asyncInstance)
    }
    
    static var `default`: PrepareAndUploadVideoPackage {
        PrepareAndUploadVideoPackage(filesRepository: FilesRepository(),
                                     feedRepository: FeedRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        switch input.videoPackage {
        case let .createModel(videoURL):
            return uploadVideoForCreateModel(videoURL: videoURL)
            
        case .lidar, .faceID:
            return uploadArchiveAndCreateFeed(videoPackage: input.videoPackage)
            
        case let .video2D(videoURL):
            return uploadVideoAndCreateFeed(videoURL: videoURL)
            
        default:
            return .just(())
        }
    }
    
    private func uploadVideoAndCreateFeed(videoURL: URL) -> Single<Void> {
        self.filesRepository.createPresignURL(filename: videoURL.lastPathComponent, parentType: .VIDEO_2D)
            .flatMap { presignMediaFileURL in
                self.filesRepository.uploadImage(image: videoURL.createVideoPreview())
                    .flatMap { videoPreview in
                        self.filesRepository.uploadFile(fileURL: videoURL, presignMediaFileURL: presignMediaFileURL)
                            .flatMap { mediaFile in
                                self.feedRepository.createFeedElement(mediafile: presignMediaFileURL.id,
                                                                      preview: videoPreview?.id)
                            }
                }
            }
    }
    
    private func uploadVideoForCreateModel(videoURL: URL) -> Single<Void> {
        self.filesRepository.createPresignURL(filename: videoURL.lastPathComponent, parentType: .RAW_VIDEO)
            .flatMap { presignMediaFileURL in
                self.filesRepository.uploadFile(fileURL: videoURL, presignMediaFileURL: presignMediaFileURL)
                    .flatMap {
                        self.filesRepository.confirmUpload(id: presignMediaFileURL.id.toString())
                    }
            }
    }
    
    private func uploadArchiveAndCreateFeed(videoPackage: VideoPackage) -> Single<Void> {
        self.createArchive(videoPackage: videoPackage)
            .flatMap { archiveURL in
                
                self.filesRepository.createPresignURL(filename: archiveURL.lastPathComponent, parentType: self.parentType(for: videoPackage))
                    .flatMap { presignMediaFileURL in
                        let radians = videoPackage.isLidarPackage ? Float.pi/2 : nil
                        return self.filesRepository.uploadImage(image: videoPackage.colorURL?.createVideoPreview(rotatedBy: radians))
                            .flatMap { previewMediaFile in
                                
                                self.filesRepository.uploadFile(fileURL: archiveURL, presignMediaFileURL: presignMediaFileURL)
                                    .flatMap {
                                        
                                        self.feedRepository.createFeedElement(mediafile: presignMediaFileURL.id,
                                                                              preview: previewMediaFile?.id)
                                    }
                            }
                    }
            }
    }
    
    private func createArchive(videoPackage: VideoPackage) -> Single<URL> {
        .deferred(queue: .global()) {
            try! videoPackage.createZip()
        }
    }
    
    private func parentType(for videoPackage: VideoPackage) -> MediaFile.ParentType {
        switch videoPackage {
        case .faceID:
            return .FACE_ID
            
        case .lidar:
            return .LIDAR
            
        default:
            return .RAW_VIDEO
        }
    }
    
}

extension PrepareAndUploadVideoPackage {
    
    struct Input {
        let videoPackage: VideoPackage
    }
    
}
