// Абстракция над всеми типами сессий
enum VideoContentProviderUniversalSession: VideoContentProviderSession {
    
    case undefined
    case createModelSession(CreateModelSession)
    case lidarSession(LidarSession)
    case faceIDSession(FaceIDSession)
    
    init() {
        self = .undefined
    }
    
    var initialized: Bool {
        asVideoContentProviderSession()?.initialized ?? false
    }
    
    var running: Bool {
        asVideoContentProviderSession()?.running ?? false
    }
    
    var videoContentProviderSessionDelegate: VideoContentProviderSessionDelegate? {
        get {
            asVideoContentProviderSession()?.videoContentProviderSessionDelegate
        }
        set {
            var session = asVideoContentProviderSession()
            session?.videoContentProviderSessionDelegate = newValue
        }
    }
    
    var recommendedVideoSettings: [String: Any]? {
        asVideoContentProviderSession()?.recommendedVideoSettings
    }
    
    func startSession() {
        asVideoContentProviderSession()?.startSession()
    }
    
    func stopSession() {
        asVideoContentProviderSession()?.stopSession()
    }
    
    func initializeSessionIfNeeded() {
        asVideoContentProviderSession()?.initializeSessionIfNeeded()
    }
    
    // MARK: - SUPPORT
    func asVideoContentProviderSession() -> VideoContentProviderSession? {
        switch self {
        case let .createModelSession(session):
            return session
            
        case let .faceIDSession(session):
            return session
            
        case let .lidarSession(session):
            return session
            
        default:
            return nil
        }
    }
    
}
