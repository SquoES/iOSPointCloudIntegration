// Абстракция над всеми типами рекордеров
enum VideoContentUniversalRecorder: VideoContentRecorder {
    
    case undefined
    case createModelRecorder(CreateModelRecorder)
    case lidarRecorder(LidarRecorder)
    case faceIDRecorder(FaceIDRecorder)
    
    var recording: Bool {
        asVideoContentRecorder()?.recording ?? false
    }
    
    func startRecording() {
        asVideoContentRecorder()?.startRecording()
    }
    
    func write(outputSample: VideoContentProviderSessionOutputSample) {
        asVideoContentRecorder()?.write(outputSample: outputSample)
    }
    
    func finish(onFinish: @escaping (VideoContentRecorderOutput) -> Void) {
        asVideoContentRecorder()?.finish(onFinish: onFinish)
    }
    
    // MARK: - SUPPORT
    func asVideoContentRecorder() -> VideoContentRecorder? {
        switch self {
        case let .createModelRecorder(recorder):
            return recorder
            
        case let .faceIDRecorder(recorder):
            return recorder
            
        case let .lidarRecorder(recorder):
            return recorder
            
        default:
            return nil
        }
    }
    
}
