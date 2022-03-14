import Foundation

enum VideoPackage {
    
    case unknown
    
    case createModel(URL)
    
    case faceID(colorURL: URL,
                depthURL: URL,
                depthMetaURL: URL)
    
    case lidar(colorURL: URL,
               depthURL: URL,
               confidenceURL: URL)
    
    case video2D(URL)
    
}
