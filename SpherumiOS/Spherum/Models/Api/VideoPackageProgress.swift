enum VideoPackageProgress {
    
    case downloading(progress: Double)
    case unarchiving(progress: Double)
    case completed(videoPackage: VideoPackage)
    
    var progress: Double {
        switch self {
        case let .downloading(progress),
             let .unarchiving(progress):
            return progress
            
        default:
            return 1.0
        }
    }
    
    var isCompleted: Bool {
        switch self {
        case .completed:
            return true
            
        default:
            return false
        }
    }
    
    var videoPackage: VideoPackage! {
        switch self {
        case let .completed(videoPackage):
            return videoPackage
            
        default:
            return nil
        }
    }
    
}
