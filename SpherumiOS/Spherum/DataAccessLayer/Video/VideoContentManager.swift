import ObjectiveC

class VideoContentManager: NSObject {
    
    private var session: VideoContentProviderSession!
    private var recorder: VideoContentRecorder!
    
    private(set) var videoContentType: VideoContentType = .createModel
    
    weak var delegate: VideoContentManagerDelegate?
    
    override init() {
        super.init()
        
        session = VideoContentManagerBuilder.universalSessionBasedOnCreateModel(with: self)
        recorder = VideoContentManagerBuilder.universalRecorderBasedOnCreateModel(for: session)
    }
    
    func update(videoContentType: VideoContentType) {
        guard self.videoContentType != videoContentType else {
            return
        }
        
        stopSession()
        
        switch videoContentType {
        case .createModel:
            session = VideoContentManagerBuilder.universalSessionBasedOnCreateModel(with: self)
            recorder = VideoContentManagerBuilder.universalRecorderBasedOnCreateModel(for: session)
            
        case .faceID:
            session = VideoContentManagerBuilder.universalSessionBasedOnFaceID(with: self)
            recorder = VideoContentManagerBuilder.universalRecorderBasedOnFaceID(for: session)
            
        case .lidar:
            session = VideoContentManagerBuilder.universalSessionBasedOnLidar(with: self)
            recorder = VideoContentManagerBuilder.universalRecorderBasedOnLidar(for: session)
        }
        
        self.videoContentType = videoContentType
        
        startSession()
        
        delegate?.videoContentManager(self,
                                      didDidChange: videoContentType)
    }
    
    func startSession() {
        session.startSession()
    }
    
    func stopSession() {
        session.stopSession()
    }
    
    func startRecording() {
        recorder.startRecording()
    }
    
    func finishRecording() {
        recorder.finish(onFinish: { [weak self] output in
            self?.handleRecordingFinished(output: output)
        })
    }
    
    deinit {
        session.stopSession()
    }
    
    // MARK: - SUPPORT
    private func handleRecordingFinished(output: VideoContentRecorderOutput) {
        self.delegate?.videoContentManager(self,
                                           didFinishWrite: output)
    }
    
}

extension VideoContentManager: VideoContentProviderSessionDelegate {
    
    func videoContentProviderSession(_ videoContentProviderSession: VideoContentProviderSession,
                                     didOutput sample: VideoContentProviderSessionOutputSample) {
        
        recorder.write(outputSample: sample)
        
        delegate?.videoContentManager(self,
                                      didOutput: sample)
        
    }
    
}

enum VideoContentManagerBuilder {
    
    private static func universalSession(_ session: VideoContentProviderUniversalSession,
                                         delegate: VideoContentProviderSessionDelegate) -> VideoContentProviderSession {
        var session = session
        session.initializeSessionIfNeeded()
        session.videoContentProviderSessionDelegate = delegate
        return session
    }
    
    static func universalSessionBasedOnCreateModel(with delegate: VideoContentProviderSessionDelegate) -> VideoContentProviderSession {
        universalSession(.createModelSession(CreateModelSession()),
                         delegate: delegate)
    }
    
    static func universalRecorderBasedOnCreateModel(for session: VideoContentProviderSession) -> VideoContentRecorder {
        VideoContentUniversalRecorder.createModelRecorder(CreateModelRecorder(videoSettings: session.recommendedVideoSettings,
                                                                              sourcePixelBufferAttributes: nil))
    }
    
    static func universalSessionBasedOnFaceID(with delegate: VideoContentProviderSessionDelegate) -> VideoContentProviderSession {
        universalSession(.faceIDSession(FaceIDSession()),
                         delegate: delegate)
    }
    
    static func universalRecorderBasedOnFaceID(for session: VideoContentProviderSession) -> VideoContentRecorder {
        VideoContentUniversalRecorder.faceIDRecorder(FaceIDRecorder(videoSettings: session.recommendedVideoSettings,
                                                                           sourcePixelBufferAttributes: nil))
    }
 
    static func universalSessionBasedOnLidar(with delegate: VideoContentProviderSessionDelegate) -> VideoContentProviderSession {
        universalSession(.lidarSession(LidarSession()),
                         delegate: delegate)
    }
    
    static func universalRecorderBasedOnLidar(for session: VideoContentProviderSession) -> VideoContentRecorder {
        VideoContentUniversalRecorder.lidarRecorder(LidarRecorder())
    }
    
}
