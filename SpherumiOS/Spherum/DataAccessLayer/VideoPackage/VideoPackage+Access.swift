extension VideoPackage {
    
    var folderURL: URL! {
        switch self {
        case let .createModel(videoURL),
             let .lidar(videoURL, _, _),
             let .faceID(videoURL, _, _),
             let .video2D(videoURL):
            
            var folderURL = videoURL
            folderURL.deleteLastPathComponent()
            
            #if DEBUG
            print("VideoPackage.folderURL:", folderURL)
            #endif
            
            return folderURL
            
        default:
            return nil
        }
    }
    
    var zipURL: URL! {
        guard var zipURL = folderURL else {
            return nil
        }
        zipURL.appendPathExtension("zip")
        
        #if DEBUG
        print("VideoPackage.zipURL:", zipURL)
        #endif
        
        return zipURL
    }
    
    var colorURL: URL! {
        switch self {
        case let .createModel(colorURL),
             let .faceID(colorURL, _, _),
             let .lidar(colorURL, _, _),
             let .video2D(colorURL):
            return colorURL
            
        default:
            return nil
        }
    }
    
    var depthURL: URL! {
        switch self {
        case let .faceID(_, depthURL, _),
             let .lidar(_, depthURL, _):
            return depthURL
            
        default:
            return nil
        }
    }
    
    var depthMetaURL: URL! {
        switch self {
        case let .faceID(_, _, depthMetaURL):
            return depthMetaURL
            
        default:
            return nil
        }
    }
    
    var confidenceURL: URL! {
        switch self {
        case let .lidar(_, _, confidenceURL):
            return confidenceURL
            
        default:
            return nil
        }
    }
    
    var isLidarPackage: Bool {
        switch self {
        case .lidar:
            return true
            
        default:
            return false
        }
    }
    
}
