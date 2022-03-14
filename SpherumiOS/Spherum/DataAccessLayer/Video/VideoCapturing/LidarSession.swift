import AVFoundation
import UIKit

final class LidarSession: NSObject, VideoContentProviderSession {
    
    private let queue = DispatchQueue(label: "com.spherum.LidarSession")
    
    private let arReceiver = ARReceiver()
    
    private(set) var initialized: Bool = false
    
    private(set) var running: Bool = false
    
    var recommendedVideoSettings: [String : Any]? {
        nil
    }
    
    weak var videoContentProviderSessionDelegate: VideoContentProviderSessionDelegate?
    
    func startSession() {
        guard !running else {
            return
        }
        
        arReceiver.start()
        running = true
    }
    
    func stopSession() {
        guard running else {
            return
        }
        
        arReceiver.pause()
        running = false
    }
    
    func initializeSessionIfNeeded() {
        guard !initialized else {
            return
        }
        
        arReceiver.delegate = self
        
        initialized = true
    }
    
}

extension LidarSession: ARDataReceiver {
    
    func onNewARData(arData: ARData) {
        videoContentProviderSessionDelegate?.videoContentProviderSession(self,
                                                                         didOutput: .lidarSample(arData))
    }
    
}
