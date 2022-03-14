class CreateModelRecorder: VideoContentRecorder {
    
    private let bufferAssetWriter: BufferAssetWriter
    
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
            let videoPackage = VideoPackage.createModelPackage()
            videoPackage.colorURL.createFoldersRecursively()
            bufferAssetWriter.startRecording(fileURL: videoPackage.colorURL)
        }
    }
    
    func write(outputSample: VideoContentProviderSessionOutputSample) {
        guard recording else {
            return
        }
        
        guard case let .createModelSample(sampleBuffer) = outputSample else {
            return
        }
        
        write(sampleBuffer: sampleBuffer)
    }
    
    func write(sampleBuffer: CMSampleBuffer) {
        bufferAssetWriter.record(cmSampleBuffer: sampleBuffer)
    }
    
    func finish(onFinish: @escaping (VideoContentRecorderOutput) -> Void) {
        bufferAssetWriter.stopRecording(onCompleted: { url in
            onFinish(.createModel(videoURL: url))
        })
    }
    
}
