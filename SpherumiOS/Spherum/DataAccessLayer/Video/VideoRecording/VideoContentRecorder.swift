protocol VideoContentRecorder {
    
    var recording: Bool { get }
    
    func startRecording()
    func write(outputSample: VideoContentProviderSessionOutputSample)
    func finish(onFinish: @escaping (VideoContentRecorderOutput) -> Void)
    
}
