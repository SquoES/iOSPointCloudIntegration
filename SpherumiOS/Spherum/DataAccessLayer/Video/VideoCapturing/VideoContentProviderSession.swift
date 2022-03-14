import AVFoundation

protocol VideoContentProviderSession {
    
    var initialized: Bool { get }
    var running: Bool { get }
    
    var videoContentProviderSessionDelegate: VideoContentProviderSessionDelegate? { get set }
    
    var recommendedVideoSettings: [String: Any]? { get }
    
    init()
    
    func initializeSessionIfNeeded()
    
    func startSession()
    func stopSession()
    
}

