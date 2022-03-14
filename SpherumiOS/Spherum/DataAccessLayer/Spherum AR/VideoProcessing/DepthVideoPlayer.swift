//
//  DepthVideoPlayer.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

class DepthVideoPlayer: NSObject {
    
    typealias Sample = (CVPixelBuffer, AVDepthData)
    typealias OnSampleUpdated = (Sample) -> Void
    
    private let fileGroup: FileGroup
    
    private var videoAssetReader: AVAssetReader!
    private var videoAssetReaderOutput: AVAssetReaderTrackOutput!
    private var videoDepthReader: VideoDepthReader!
    
    private var readingStarted: Bool = false
    
    private var displayLink: CADisplayLink!
    
    private let processingQ = DispatchQueue(label: "DepthVideoPlayer_processingQ")
    
    var onSampleUpdated: OnSampleUpdated?
    
    init(fileGroup: FileGroup) throws {
        self.fileGroup = fileGroup
        
        super.init()
        
        try self.prepareReaders()
        self.prepareDisplayLink()
    }
    
    private func prepareReaders() throws {
        self.videoDepthReader = try VideoDepthReader(depthFileURL: fileGroup.depthURL,
                                                     depthMetaFileURL: fileGroup.depthMetaURL)
        
        let videoAsset = AVAsset(url: self.fileGroup.movURL)
        self.videoAssetReader = try AVAssetReader(asset: videoAsset)
        let videoTrack = videoAsset.tracks(withMediaType: .video)[0]
        self.videoAssetReaderOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: [
            kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)
        ])
        
        self.videoAssetReader.add(self.videoAssetReaderOutput)
//        print("READERS CONFIGURED")
    }
    
    private func prepareDisplayLink() {
        self.displayLink = CADisplayLink(target: self,
                                         selector: #selector(extractNextFrame))
        self.displayLink.preferredFramesPerSecond = 30
        self.displayLink.isPaused = true
        self.displayLink.add(to: .main,
                             forMode: .common)
//        print("DISPLAY LINK CONFIGURED")
    }
    
    func resume() {
        if !self.readingStarted {
            self.videoAssetReader.startReading()
            self.readingStarted = true
        }
        self.displayLink.isPaused = false
//        print("RESUMED")
    }
    
    func pause() {
        if self.readingStarted {
            self.videoAssetReader.cancelReading()
            self.readingStarted = false 
        }
        self.displayLink.isPaused = true
//        print("PAUSED")
    }
    
    @objc private func extractNextFrame() {
        guard self.videoAssetReader.status == .reading else {
//            print("VIDEO ASSET READER NOT READING")
            return
        }
        guard let videoSampleBuffer = self.videoAssetReaderOutput.copyNextSampleBuffer() else {
//            print("NO SAMPLE BUFFER")
            return
        }
//        print("FRAME TIME: \(videoSampleBuffer.presentationTimeStamp)")
        guard let pixelBuffer = videoSampleBuffer.imageBuffer else {
//            print("NO PIXEL BUFFER")
            return
        }
        guard let depthData = self.videoDepthReader.readNextDepthData() else {
//            print("NO DEPTH DATA")
            return
        }
//        print("VIDEO AND DEPTH DATA READED SUCCESSFULY")
        
//        print("read buffer width:", CVPixelBufferGetWidth(pixelBuffer))
//        print("read buffer height:", CVPixelBufferGetHeight(pixelBuffer))
//        print("read depth width:", CVPixelBufferGetWidth(depthData.depthDataMap))
//        print("read depth height:", CVPixelBufferGetHeight(depthData.depthDataMap))
        
        let sample: Sample = (pixelBuffer, depthData)
        self.onSampleUpdated?(sample)
    }
    
}
