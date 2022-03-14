import AVFoundation

class PointCloudMetalViewContentAdaptor {
    
    private weak var pointCloudMetalView: PointCloudMetalView?
    
    private var depthVideoPlayer: DepthVideoPlayer?
    private var audioPlayer: AVPlayer?
    
    private(set) var state: State = .showing
    
    func set(pointCloudMetalView: PointCloudMetalView?) {
        self.pointCloudMetalView = pointCloudMetalView
    }
    
    func play(videoURL: URL, depthURL: URL, depthMetaURL: URL) {
        stopPlaying()

        state = .playing
                
        depthVideoPlayer = try! DepthVideoPlayer(fileGroup: .init(movURL: videoURL,
                                                                  depthURL: depthURL,
                                                                  depthMetaURL: depthMetaURL))
        depthVideoPlayer?.onSampleUpdated = { [weak self] in
            guard self?.state == .playing else {
                return
            }
            self?.pointCloudMetalView?.setDepthFrame($0.1,
                                                     withTexture: $0.0)
        }
        
        try! AVAudioSession.sharedInstance().setActive(false)
        try! AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = AVPlayer(url: videoURL)
        
        depthVideoPlayer?.resume()
        audioPlayer?.play()
    }
    
    func show(sampleBuffer: CMSampleBuffer, depthData: AVDepthData) {
        guard state == .showing else {
            return
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        pointCloudMetalView?.setDepthFrame(depthData,
                                           withTexture: pixelBuffer)
    }
    
    func stopPlaying() {
        state = .showing
        
        depthVideoPlayer?.onSampleUpdated = nil
        depthVideoPlayer?.pause()
        
        audioPlayer?.pause()
    }
    
}
 
extension PointCloudMetalViewContentAdaptor {
    
    enum State {
        case showing
        case playing
    }
    
}
