import Foundation
import AVFoundation

struct SampleInfo {
    let width: Int
    let height: Int
    let pixelFormatType: OSType
    
    func defaultIfZero() -> SampleInfo {
        if width == 0 || height == 0 || pixelFormatType == 0 {
            return self
        } else {
            return self
        }
    }
}

class LidarMetaInfo {
    
    static var color: SampleInfo = .init(width: 0, height: 0, pixelFormatType: 0)
    static var depth: SampleInfo {
        .init(width: 256, height: 144, pixelFormatType: 1717855600)
    }
    static var confidence: SampleInfo {
        .init(width: 256, height: 144, pixelFormatType: 1278226488)
    }
    
    static var colorSampleSize: Int = 0
    static var depthSampleSize: Int {
        147456
    }
    static var confidenceSampleSize: Int {
        36864
    }
    
}
