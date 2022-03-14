import Foundation
import AVFoundation
import VideoToolbox

class ARDataAssetWriter: NSObject {
    
    private var colorBufferWriter: BufferAssetWriter!
    private var depthHandle: CVPixelBufferFileHandle!
    private var confidenceHandle: CVPixelBufferFileHandle!
    
    private var prepared: Bool = false
    private(set) var recording: Bool = false
    
    private var colorURL: URL!
    private var depthURL: URL!
    private var confidenceURL: URL!
    
    func startRecording() {
        prepareWritersIfNeeded()
        recording = true
    }
    
    func record(arData: ARData) {
        
        guard recording else {
            return
        }
        
        guard let colorBuffer = arData.colorImage,
              let depthBuffer = arData.depthSmoothImage,
              let confidenceBuffer = arData.confidenceSmoothImage,
              let presentationTime = arData.captureTime else {
            return
        }
        
        guard colorBufferWriter.record(cvPixelBuffer: colorBuffer,
                                       presentationTime: presentationTime) else {
            return 
        }
        
        record(cvPixelBuffer: depthBuffer,
               toHandle: &depthHandle)//,
//               withLidarMetaSampleInfo: &LidarMetaInfo.depth,
//               andSampleSize: &LidarMetaInfo.depthSampleSize)
        
        record(cvPixelBuffer: confidenceBuffer,
               toHandle: &confidenceHandle)//,
//               withLidarMetaSampleInfo: &LidarMetaInfo.confidence,
//               andSampleSize: &LidarMetaInfo.confidenceSampleSize)
        
    }
    
    func stopRecording(onCompleted: @escaping (URL, URL, URL) -> Void) {
        
        guard recording else {
            return
        }
        
        recording = false
        prepared = false
        
        [depthHandle, confidenceHandle].forEach { $0?.finish() }
        
        colorBufferWriter.stopRecording { [weak self] _ in
            guard let self = self else {
                return
            }
            onCompleted(self.colorURL, self.depthURL, self.confidenceURL)
        }
    }
    
    private func prepareWritersIfNeeded() {
        
        guard !prepared else {
            return
        }
        
        let videoPackage = VideoPackage.lidarPackage()
        videoPackage.colorURL.createFoldersRecursively()
        
        colorURL = videoPackage.colorURL
        depthURL = videoPackage.depthURL
        confidenceURL = videoPackage.confidenceURL
        
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264.rawValue,
            AVVideoWidthKey: 1920,
            AVVideoHeightKey: 1080
        ]
        
        let sourcePixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
            kCVPixelBufferWidthKey as String: 1920,
            kCVPixelBufferHeightKey as String: 1080
        ]
        
        colorBufferWriter = BufferAssetWriter(videoSettings: videoSettings,
                                              sourcePixelBufferAttributes: sourcePixelBufferAttributes)
        colorBufferWriter.startRecording(fileURL: colorURL)
        depthHandle = .init(fileURL: depthURL, writing: true)
        confidenceHandle = .init(fileURL: confidenceURL, writing: true)
        
        prepared = true
        
    }
    
    private func record(cvPixelBuffer: CVPixelBuffer,
                        toHandle handle: inout CVPixelBufferFileHandle) { //,
//                        withLidarMetaSampleInfo sampleInfo: inout SampleInfo,
//                        andSampleSize sampleSize: inout Int) {
        
//        sampleInfo = SampleInfo(width: CVPixelBufferGetWidth(cvPixelBuffer),
//                                height: CVPixelBufferGetHeight(cvPixelBuffer),
//                                pixelFormatType: CVPixelBufferGetPixelFormatType(cvPixelBuffer))
        
        handle.write(cvPixelBuffer: cvPixelBuffer)
//        sampleSize = handle.sampleSize
        
    }
    
}
