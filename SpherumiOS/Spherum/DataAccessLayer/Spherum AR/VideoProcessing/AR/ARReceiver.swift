import ARKit

class ARReceiver: NSObject, ARSessionDelegate {
    let arSession = ARSession()
    weak var delegate: ARDataReceiver?
    
    override init() {
        super.init()
        arSession.delegate = self
        start()
    }
    
    func start() { 
        let frameSemantic: ARConfiguration.FrameSemantics = [.sceneDepth, .smoothedSceneDepth]
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(frameSemantic) else {
            return
        }
        let config = ARWorldTrackingConfiguration()
        let videoFormats = ARWorldTrackingConfiguration.supportedVideoFormats
        for videoFormat in videoFormats {
            print("framesPerSecond:", videoFormat.framesPerSecond)
            print("imageResolution:", videoFormat.imageResolution)
//            print("captureDeviceType:", videoFormat.captureDeviceType)
        }
        if let fullHDVideoFormat = videoFormats.first(where: { $0.imageResolution == .init(width: 1920, height: 1080) }) {
            config.videoFormat = fullHDVideoFormat
        }
        config.frameSemantics = frameSemantic
        arSession.run(config)
        print("RECORDING STARTED")
    }
    
    func pause() {
        arSession.pause()
        print("RECORDING PAUSED")
    }
  
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        if frame.sceneDepth.isNotNil || frame.smoothedSceneDepth.isNotNil {
            let arData = ARData()
            
//            arData.depthImage = frame.sceneDepth?.depthMap
//            arData.confidenceImage = frame.sceneDepth?.confidenceMap

            arData.depthSmoothImage = frame.smoothedSceneDepth?.depthMap
            arData.confidenceSmoothImage = frame.smoothedSceneDepth?.confidenceMap
            
            arData.colorImage = frame.capturedImage
//            ARData.cameraIntrinsics = frame.camera.intrinsics // TEMP SOLUTION
//            ARData.cameraResolution = frame.camera.imageResolution // TEMP SOLUTION
            
//            print("ARData.cameraIntrinsics:", ARData.cameraIntrinsics)
//            print("ARData.cameraResolution:", ARData.cameraResolution)
            
            arData.captureTime = frame.timestamp
            
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.onNewARData(arData: arData)
            }
            
//            #if DEBUG
//            print("ARDATA SENDED")
//            #endif
        } else {
//            #if DEBUG
//            print("NO ARDATA")
//            #endif
        }
    }
}
