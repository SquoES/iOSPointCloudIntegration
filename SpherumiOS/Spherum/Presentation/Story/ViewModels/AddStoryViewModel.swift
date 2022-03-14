import RxSwift
import RxCocoa
import RxMVVM

class AddStoryViewModel: ViewModel {
    
    private var prepareVideoDisposeBag: DisposeBag!
    
    private let videoContentManager = VideoContentManager()
    
    let state = BehaviorRelay<AddStoryState>(value: .selectingMode)
    let recordType = BehaviorRelay<RecordType>(value: .createModel)
    
    let nextSample = BehaviorRelay<VideoContentProviderSessionOutputSample?>(value: nil)
    let recorderOutput = BehaviorRelay<VideoContentRecorderOutput?>(value: nil)
    
    let startRecording = PublishSubject<Void>()
    let stopRecording = PublishSubject<Void>()
    
    let publish = PublishSubject<Void>()
    let cancelPublish = PublishSubject<Void>()
    
    let didAppear = PublishSubject<Void>()
    let didDisappear = PublishSubject<Void>()
    
    override func subscribe() {
        
        videoContentManager.delegate = self
        
        recordType.bind(onNext: { [weak self] in
            switch $0 {
            case .createModel:
                self?.videoContentManager.update(videoContentType: .createModel)
                
            case .faceID:
                self?.videoContentManager.update(videoContentType: .faceID)
                
            case .lidar:
                self?.videoContentManager.update(videoContentType: .lidar)
            }
        }).disposed(by: disposeBag)
        
        publish.bind(onNext: { [weak self] in
            self?.publishAction()
        }).disposed(by: disposeBag)
        
        cancelPublish.bind(onNext: { [weak self] in
            self?.prepareVideoDisposeBag = nil
        }).disposed(by: disposeBag)
        
        didAppear.bind(onNext: { [weak self] in
            self?.videoContentManager.startSession()
        }).disposed(by: disposeBag)
        
        didDisappear.bind(onNext: { [weak self] in
            self?.videoContentManager.stopSession()
        }).disposed(by: disposeBag)
        
        startRecording.bind(onNext: { [weak self] in
            self?.videoContentManager.startSession()
            self?.videoContentManager.startRecording()
            self?.state.accept(.recording)
        }).disposed(by: disposeBag)
        
        stopRecording.bind(onNext: { [weak self] in
            self?.videoContentManager.finishRecording()
            self?.videoContentManager.stopSession()
            self?.state.accept(.presenting)
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func publishAction() {
        prepareVideoDisposeBag = DisposeBag()
        
        guard let videoPackage = getVideoPackage() else {
            return
        }
        
        videoContentManager.stopSession()

        PrepareAndUploadVideoPackage.default.use(input: .init(videoPackage: videoPackage))
            .do(onSubscribed: { [weak self] in
                self?.isLoading.onNext(true)
            }, onDispose: { [weak self] in
                self?.isLoading.onNext(false)
            }).subscribe(onSuccess: {
                Navigator.dismiss()
            }, onError: { [weak self] in
                self?.handleError($0)
            }).disposed(by: prepareVideoDisposeBag)
    }
    
    private func getVideoPackage() -> VideoPackage? {
        guard let output = recorderOutput.value else {
            return nil
        }
        
        switch output {
        case let .createModel(videoURL):
//            let littleBigURL = Bundle.main.url(forResource: "IMG_3369", withExtension: "mp4")!
//            return .createModel(littleBigURL)
            return .createModel(videoURL)
            
        case let .faceID(videoURL, depthDataURL, depthMetaURL):
            return .faceID(colorURL: videoURL, depthURL: depthDataURL, depthMetaURL: depthMetaURL)
            
        case let .lidar(videoURL, depthDataURL, confidenceDataURL):
            return .lidar(colorURL: videoURL, depthURL: depthDataURL, confidenceURL: confidenceDataURL)
            
        default:
            return nil
        }
    }
    
}

extension AddStoryViewModel: VideoContentManagerDelegate {
    
    func videoContentManager(_ videoContentManager: VideoContentManager, didDidChange videoContentType: VideoContentType) {
        
    }
    
    func videoContentManager(_ videoContentManager: VideoContentManager, didOutput sample: VideoContentProviderSessionOutputSample) {
        nextSample.accept(sample)
    }
    
    func videoContentManager(_ videoContentManager: VideoContentManager, didFinishWrite output: VideoContentRecorderOutput) {
//        switch output {
//        case .createModel(let videoURL):
//            recorderOutput.accept(.createModel(videoURL: Bundle.main.url(forResource: "IMG_3369", withExtension: "mp4")!))
//        default:
//            recorderOutput.accept(output)
//        }
        recorderOutput.accept(output)
    }
    
}

enum AddStoryState {
    case selectingMode
    case recording
    case presenting
}
