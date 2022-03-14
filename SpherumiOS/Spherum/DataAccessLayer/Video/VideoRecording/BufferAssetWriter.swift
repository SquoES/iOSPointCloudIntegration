import Foundation
import AVFoundation

class BufferAssetWriter: NSObject {
    
    private let videoSettings: [String: Any]?
    private let sourcePixelBufferAttributes: [String: Any]?
//    private let videoSettings: [String: Any] = [
//        AVVideoCodecKey: AVVideoCodecType.h264.rawValue,
//        AVVideoWidthKey: 1440,
//        AVVideoHeightKey: 1920
//    ]
//
//    private let sourcePixelBufferAttributes: [String: Any] = [
//        kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
//        kCVPixelBufferWidthKey as String: 1440,
//        kCVPixelBufferHeightKey as String: 1920
//    ]
    
    private let audioSettings: [String: Any] = [
        AVFormatIDKey : kAudioFormatMPEG4AAC,
        AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0,
        AVEncoderBitRateKey: 192000
    ]
    
    private var started: Bool = false
    
    private var writer: AVAssetWriter!
    private var videoInput: AVAssetWriterInput!
    private var audioInput: AVAssetWriterInput!
    private var adaptor: AVAssetWriterInputPixelBufferAdaptor!
    
    private var fileURL: URL!
    
    var writing: Bool {
        writer?.status == .writing
    }
    
    init(videoSettings: [String: Any]? = nil,
         sourcePixelBufferAttributes: [String: Any]? = nil) {
        
        self.videoSettings = videoSettings
        self.sourcePixelBufferAttributes = sourcePixelBufferAttributes
        
    }
    
    func startRecording(fileURL: URL) {
        self.fileURL = fileURL
        
        prepareWriterIfNeeded()
    }
    
    @discardableResult
    func record(cvPixelBuffer: CVPixelBuffer, presentationTime: TimeInterval) -> Bool {
        
        guard writer.status != .failed && videoInput.isReadyForMoreMediaData else {
            return false 
        }
        
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let presentationTimeStamp = CMTime(value: CMTimeValue(presentationTime * Double(timeScale)),
                                           timescale: timeScale)
        
        if !started {
            writer.startSession(atSourceTime: presentationTimeStamp)
            started = true
        }
        
        adaptor.append(cvPixelBuffer,
                       withPresentationTime: presentationTimeStamp)
        
        return true
        
    }
    
    @discardableResult
    func record(cmSampleBuffer: CMSampleBuffer) -> Bool {
        
        guard writer.status != .failed && videoInput.isReadyForMoreMediaData else {
            return false
        }
        
        guard let cvPixelBuffer = CMSampleBufferGetImageBuffer(cmSampleBuffer) else {
            return false
        }
        
        let presentationTimeStamp = CMSampleBufferGetPresentationTimeStamp(cmSampleBuffer)
        
        if !started {
            writer.startSession(atSourceTime: presentationTimeStamp)
            started = true
        }
        
        adaptor.append(cvPixelBuffer,
                       withPresentationTime: presentationTimeStamp)
        
        return true
    }
    
    @discardableResult
    func recordAudio(cmSampleBuffer: CMSampleBuffer) -> Bool {
        guard writer.status != .failed && audioInput.isReadyForMoreMediaData else {
            return false
        }
        
        let presentationTimeStamp = CMSampleBufferGetPresentationTimeStamp(cmSampleBuffer)
        
        if !started {
            writer.startSession(atSourceTime: presentationTimeStamp)
            started = true
        }
        
        audioInput.append(cmSampleBuffer)
        
        return true
    }
    
    func stopRecording(onCompleted: @escaping (URL) -> Void) {
        
        guard writer.status == .writing else {
            return
        }
        
        started = false
        
        videoInput.markAsFinished()
        audioInput.markAsFinished()
        writer.finishWriting { [weak self] in
            guard let fileURL = self?.fileURL else {
                return
            }
            onCompleted(fileURL)
        }
        
    }
    
    private func prepareWriterIfNeeded() {
        
        guard writer?.status != .writing else {
            return
        }
        
        videoInput = AVAssetWriterInput(mediaType: .video,
                                        outputSettings: videoSettings)
        videoInput.expectsMediaDataInRealTime = true
        
        adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoInput,
                                                       sourcePixelBufferAttributes: sourcePixelBufferAttributes)
        
        
        audioInput = AVAssetWriterInput(mediaType: .audio,
                                        outputSettings: audioSettings)
        audioInput.expectsMediaDataInRealTime = true
        
        
        writer = try! AVAssetWriter(outputURL: fileURL,
                                    fileType: .mov)
        writer.add(videoInput)
        writer.add(audioInput)
        
        let started = writer.startWriting()
        #if DEBUG
        if started {
            print("WRITER STARTED WITH FILE AT URL:", fileURL!)
        } else if let error = writer.error {
            print("WRITER FAILED WITH ERROR:", error)
        }
        #endif
    }
    
}
