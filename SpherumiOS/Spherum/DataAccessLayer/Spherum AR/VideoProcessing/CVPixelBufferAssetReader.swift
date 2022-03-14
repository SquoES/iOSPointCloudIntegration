import Foundation
import AVFoundation

class CVPixelBufferAssetReader: NSObject {
    
    private let outputSettings: [String: Any] = [
        kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
    ]
    
    private var reader: AVAssetReader!
    private var output: AVAssetReaderTrackOutput!
    
    private var fileURL: URL!
    
    func startReading(fileURL: URL) {
        
        self.fileURL = fileURL
        
        prepareReaderIfNeeded()
        
    }
    
    func readCVPixelBuffer() -> CVPixelBuffer? {
        
        guard reader.status == .reading else {
            return nil
        }
        
        guard let nextSample = output.copyNextSampleBuffer() else {
            return nil
        }
        
        guard let cvPixelBuffer = CMSampleBufferGetImageBuffer(nextSample) else {
            return nil
        }
        
        return cvPixelBuffer
        
    }
    
    private func prepareReaderIfNeeded() {
        
        guard reader?.status != .reading else {
            return
        }
        
        let videoAsset = AVAsset(url: fileURL)
        
        reader = try! AVAssetReader(asset: videoAsset)
        
//        let outputSettings: [String: Any] = [
//            AVVideoCodecKey : AVVideoCodecType.h264,
//            AVVideoWidthKey : Int(ARData.cameraResolution.width),
//            AVVideoHeightKey : Int(ARData.cameraResolution.height)
//        ]
        
        output = AVAssetReaderTrackOutput(track: videoAsset.tracks[0], outputSettings: [
            kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
        ])
        reader.add(output)
        
        let readingStarted = reader.startReading()
        #if DEBUG
        if readingStarted {
            print("READING STARTED")
        } else if let error = reader.error {
            print("READING START FAILED WITH ERROR:", error.localizedDescription)
        }
        #endif
        
    }
    
}
