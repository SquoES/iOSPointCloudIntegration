import AVFoundation
import ARKit

class ARPointCloudViewContentAdaptor: ARDataReceiver {
    
    private lazy var arDataAssetReader: ARDataAssetReader = {
        let arDataAssetReader = ARDataAssetReader()
        arDataAssetReader.delegate = self
        return arDataAssetReader
    }()

    private weak var arPointCloudView: ARPointCloudView?
    
    private(set) var state: State = .showing
    
    func set(arPointCloudView: ARPointCloudView?) {
        self.arPointCloudView = arPointCloudView
    }
    
    func play(videoURL: URL, depthURL: URL, confidenceURL: URL) {
        stopPlaying()
        
        state = .playing
        arDataAssetReader.startReading(colorURL: videoURL,
                                       depthURL: depthURL,
                                       confidenceURL: confidenceURL)
    }
    
    func show(arData: ARData) {
        guard state == .showing else {
            return
        }
        
        arPointCloudView?.lastARData = arData
    }
    
    func stopPlaying() {
        state = .showing
        
        arDataAssetReader.stopReading()
    }
    
    func onNewARData(arData: ARData) {
        guard state == .playing else {
            return
        }
        
        arPointCloudView?.lastARData = arData
    }
    
}

extension ARPointCloudViewContentAdaptor {
    
    enum State {
        case showing
        case playing
    }
    
}
