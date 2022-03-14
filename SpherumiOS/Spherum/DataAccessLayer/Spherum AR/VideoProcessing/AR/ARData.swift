import Foundation
import ARKit
import AVFoundation

class ARData {
//    var depthImage: CVPixelBuffer?
    var depthSmoothImage: CVPixelBuffer? // +
    var colorImage: CVPixelBuffer? // +
//    var confidenceImage: CVPixelBuffer?
    var confidenceSmoothImage: CVPixelBuffer? // +
    var captureTime: TimeInterval?
    
    static var cameraIntrinsics: simd_float3x3 {
        simd_float3x3([
            [1415.7267, 0.0, 0.0],
            [0.0, 1415.7267, 0.0],
            [957.4654, 541.9824, 1.0]
        ])
    }
    static var cameraResolution: CGSize {
        .init(width: 1920,
              height: 1080)
    }
}
