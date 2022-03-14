import Foundation
import AVFoundation

class ARDataAssetReader: NSObject {
    
//    private var colorReader: AVAssetReader!
//    private var depthReader: AVAssetReader!
//    private var confidenceReader: AVAssetReader!
//
//    private var colorOutput: AVAssetReaderTrackOutput!
//    private var depthOutput: AVAssetReaderTrackOutput!
//    private var confidenceOutput: AVAssetReaderTrackOutput!
    
//    private var colorHandle: CVPixelBufferFileHandle!
    private var colorBufferReader: CVPixelBufferAssetReader!
    private var depthHandle: CVPixelBufferFileHandle!
    private var confidenceHandle: CVPixelBufferFileHandle!
    
    private var colorURL: URL!
    private var depthURL: URL!
    private var confidenceURL: URL!
    
    private var displayLink: CADisplayLink!
    
    private var reading: Bool = false {
        didSet {
            displayLink.isPaused = !reading
        }
    }
    
    private let processingQ = DispatchQueue(label: "ARDataAssetReader_processingQ")
    
    weak var delegate: ARDataReceiver?
    
    var lastArData: ARData? {
        didSet {
            if let arData = lastArData {
                delegate?.onNewARData(arData: arData)
            }
        }
    }
    
    override init() {
        super.init()
        
        prepareDisplayLink()
    }
    
    func startReading(colorURL: URL, depthURL: URL, confidenceURL: URL) {
        
        reading = false
        
        self.colorURL = colorURL
        self.depthURL = depthURL
        self.confidenceURL = confidenceURL
        
        prepareHandles()
        
        reading = true
        displayLink.isPaused = false 
        
    }
    
    func stopReading() {
        
        reading = false
        displayLink.isPaused = true
        
    }
    
    private func prepareHandles() {
        
        colorBufferReader = CVPixelBufferAssetReader()
        colorBufferReader.startReading(fileURL: colorURL)
//        prepareHandle(&colorHandle,
//                      forFileWithURL: colorURL,
//                      andSampleSize: LidarMetaInfo.colorSampleSize)
        prepareHandle(&depthHandle,
                      forFileWithURL: depthURL,
                      andSampleSize: LidarMetaInfo.depthSampleSize)
        prepareHandle(&confidenceHandle,
                      forFileWithURL: confidenceURL,
                      andSampleSize: LidarMetaInfo.confidenceSampleSize)
        
//        prepareReader(&colorReader,
//                      withOutput: &colorOutput,
//                      forFileWithURL: colorURL)
//        prepareReader(&depthReader,
//                      withOutput: &depthOutput,
//                      forFileWithURL: depthURL)
//        prepareReader(&confidenceReader,
//                      withOutput: &confidenceOutput,
//                      forFileWithURL: confidenceURL)
        
    }
    
    private func prepareHandle(_ handle: inout CVPixelBufferFileHandle!,
                               forFileWithURL fileURL: URL,
                               andSampleSize sampleSize: Int) {
        
        handle = CVPixelBufferFileHandle(fileURL: fileURL,
                                         writing: false,
                                         sampleSize: sampleSize)
    }
    
//    private func prepareReader(_ reader: inout AVAssetReader!,
//                               withOutput output: inout AVAssetReaderTrackOutput!,
//                               forFileWithURL fileURL: URL) {
//
//        let videoAsset = AVAsset(url: fileURL)
//        reader = try! AVAssetReader(asset: videoAsset)
//        output = AVAssetReaderTrackOutput(track: videoAsset.tracks[0],
//                                          outputSettings: nil)
//        reader.add(output)
//
//        let readingStarted = reader.startReading()
//        #if DEBUG
//        print("READER READING STARTED:", readingStarted)
//        #endif
//
//    }
    
    private func prepareDisplayLink() {
        displayLink = CADisplayLink(target: self,
                                    selector: #selector(extractNextFrame))
        displayLink.preferredFramesPerSecond = 60
        displayLink.isPaused = true
        displayLink.add(to: .main,
                        forMode: .common)
        print("DISPLAY LINK CONFIGURED")
    }
    
    @objc private func extractNextFrame() {
        
        guard reading else {
            return
        }
        
//        guard let colorBuffer = colorHandle.read(usingSampleInfo: LidarMetaInfo.color,
//                                                 attributes: CVPixelBufferPixelFormat.format_420f.attributes) else {
        guard let colorBuffer = colorBufferReader.readCVPixelBuffer() else {
//            print("NO COLOR IMAGE")
            return
        }
        
        guard let depthBuffer = depthHandle.read(usingSampleInfo: LidarMetaInfo.depth,
                                                 attributes: CVPixelBufferPixelFormat.format_fdep.attributes) else {
//            print("NO DEPTH IMAGE")
            return
        }

        guard let confidenceBuffer = confidenceHandle.read(usingSampleInfo: LidarMetaInfo.confidence,
                                                           attributes: CVPixelBufferPixelFormat.format_L008.attributes) else {
//            print("NO CONFIDENCE IMAGE")
            return
        }
        
        let arData = ARData()

        arData.colorImage = colorBuffer
        arData.depthSmoothImage = depthBuffer
        arData.confidenceSmoothImage = confidenceBuffer

        lastArData = arData
        delegate?.onNewARData(arData: arData)
        
//        print("AR EXISTS")
        
    }
    
}
