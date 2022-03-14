class FaceIDRecorder: VideoContentRecorder {
    
    private let bufferAssetWriter: BufferAssetWriter
    private var videoDepthWriter: VideoDepthWriter!
    private var depthDataURL: URL!
    private var depthMetaURL: URL!
    
    var recording: Bool {
        bufferAssetWriter.writing
    }
    
    init(videoSettings: [String: Any]? = nil,
         sourcePixelBufferAttributes: [String: Any]? = nil) {
        
        bufferAssetWriter = BufferAssetWriter(videoSettings: videoSettings,
                                              sourcePixelBufferAttributes: sourcePixelBufferAttributes)
    }
    
    func startRecording() {
        if !recording {
            let videoPackage = VideoPackage.faceIDPackage()
            videoPackage.colorURL.createFoldersRecursively()
            bufferAssetWriter.startRecording(fileURL: videoPackage.colorURL)
            
            depthDataURL = videoPackage.depthURL
            depthMetaURL = videoPackage.depthMetaURL
            videoDepthWriter = try! VideoDepthWriter(depthFileURL: depthDataURL,
                                                     depthMetaFileURL: depthMetaURL)
        }
    }
    
    func write(outputSample: VideoContentProviderSessionOutputSample) {
        guard recording else {
            return
        }
        
        switch outputSample {
        case let .faceIDVideoSample(sampleBuffer, depthData):
            write(sampleBuffer: sampleBuffer,
                  depthData: depthData)
            
        case let .faceIDAudioSample(sampleBuffer):
            bufferAssetWriter.recordAudio(cmSampleBuffer: sampleBuffer)
            
        default:
            break
        }
        
    }
    
    func write(sampleBuffer: CMSampleBuffer, depthData: AVDepthData) {
        bufferAssetWriter.record(cmSampleBuffer: sampleBuffer)
        videoDepthWriter.add(depthData: depthData)
    }
    
    func finish(onFinish: @escaping (VideoContentRecorderOutput) -> Void) {
        videoDepthWriter.finish()
        
        bufferAssetWriter.stopRecording(onCompleted: { [weak self] url in
            guard let depthDataURL = self?.depthDataURL,
                  let depthMetaURL = self?.depthMetaURL else {
                      return
                  }
            onFinish(.faceID(videoURL: url,
                             depthDataURL: depthDataURL,
                             depthMetaURL: depthMetaURL))
        })
    }
    
}
