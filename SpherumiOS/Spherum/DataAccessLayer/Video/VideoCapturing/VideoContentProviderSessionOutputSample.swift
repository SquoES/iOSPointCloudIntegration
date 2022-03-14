import AVFoundation

enum VideoContentProviderSessionOutputSample {
    
    case createModelSample(CMSampleBuffer)
    case lidarSample(ARData)
    case faceIDVideoSample(CMSampleBuffer, AVDepthData)
    case faceIDAudioSample(CMSampleBuffer)
    
    var isCreateModelSample: Bool {
        switch self {
        case .createModelSample:
            return true
            
        default:
            return false
        }
    }
    
    var isFaceIDSample: Bool {
        switch self {
        case .faceIDVideoSample, .faceIDAudioSample:
            return true
            
        default:
            return false
        }
    }
    
    var isLidarSample: Bool {
        switch self {
        case .lidarSample:
            return true
            
        default:
            return false
        }
    }
    
}
