enum VideoContentRecorderOutput {
    
    case unknown
    case createModel(videoURL: URL)
    case faceID(videoURL: URL, depthDataURL: URL, depthMetaURL: URL)
    case lidar(videoURL: URL, depthDataURL: URL, confidenceDataURL: URL)
    
}
