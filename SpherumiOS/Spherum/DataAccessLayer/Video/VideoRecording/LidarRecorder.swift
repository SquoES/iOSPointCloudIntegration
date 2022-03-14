class LidarRecorder: VideoContentRecorder {
    
    private let arDataAssetWriter = ARDataAssetWriter()
    
    var recording: Bool {
        arDataAssetWriter.recording
    }
    
    func startRecording() {
        arDataAssetWriter.startRecording()
    }
    
    func write(outputSample: VideoContentProviderSessionOutputSample) {
        guard recording else {
            return
        }
        
        guard case let .lidarSample(arData) = outputSample else {
            return
        }
        
        write(arData: arData)
    }
    
    func write(arData: ARData) {
        arDataAssetWriter.record(arData: arData)
    }
    
    func finish(onFinish: @escaping (VideoContentRecorderOutput) -> Void) {
        arDataAssetWriter.stopRecording(onCompleted: { video, depth, confidence in
            onFinish(.lidar(videoURL: video,
                            depthDataURL: depth,
                            confidenceDataURL: confidence))
        })
    }
    
}
