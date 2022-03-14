//
//  DepthVideoReader.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 08.07.2021.
//

import Foundation
import AVFoundation

class DepthVideoReader: NSObject, DepthVideoSamplesReader {
    
    typealias Sample = (CVPixelBuffer, AVDepthData)
    
    private let fileGroup: FileGroup
    
    private var videoAssetReader: AVAssetReader!
    private var videoAssetReaderOutput: AVAssetReaderTrackOutput!
    private var videoDepthReader: VideoDepthReader!
    
    init(fileGroup: FileGroup) throws {
        self.fileGroup = fileGroup
        
        super.init()
        
        try self.prepareReaders()
    }
    
    private func prepareReaders() throws {
        self.videoDepthReader = try VideoDepthReader(depthFileURL: fileGroup.depthURL,
                                                     depthMetaFileURL: fileGroup.depthMetaURL)
        
        let videoAsset = AVAsset(url: self.fileGroup.movURL)
        self.videoAssetReader = try AVAssetReader(asset: videoAsset)
        let videoTrack = videoAsset.tracks(withMediaType: .video)[0]
        self.videoAssetReaderOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
        ])
        self.videoAssetReader.add(self.videoAssetReaderOutput)
//        print("READERS CONFIGURED")
        
        self.videoAssetReader.startReading()
    }
    
    func extractNextSample() -> Sample? {
        guard self.videoAssetReader.status == .reading else {
//            print("VIDEO ASSET READER NOT READING")
            return nil
        }
        guard let videoSampleBuffer = self.videoAssetReaderOutput.copyNextSampleBuffer() else {
//            print("NO SAMPLE BUFFER")
            return nil
        }
//        print("FRAME TIME: \(videoSampleBuffer.presentationTimeStamp)")
        guard let pixelBuffer = videoSampleBuffer.imageBuffer else {
//            print("NO PIXEL BUFFER")
            return nil
        }
        guard let depthData = self.videoDepthReader.readNextDepthData() else {
//            print("NO DEPTH DATA")
            return nil
        }
//        print("VIDEO AND DEPTH DATA READED SUCCESSFULY")
        let sample: Sample = (pixelBuffer, depthData)
        return sample
    }
    
    func extractNextDepthData() -> AVDepthData! {
        guard let depthData = self.videoDepthReader.readNextDepthData() else {
//            print("NO DEPTH DATA")
            return nil
        }
//        print("DEPTH DATA READED SUCCESSFULY")
        return depthData
    }
    
    func extractNextPixelBuffer() -> Unmanaged<CVPixelBuffer>! {
        guard let videoSampleBuffer = self.videoAssetReaderOutput.copyNextSampleBuffer() else {
//            print("NO SAMPLE BUFFER")
            return nil
        }
//        print("FRAME TIME: \(videoSampleBuffer.presentationTimeStamp)")
        guard let pixelBuffer = videoSampleBuffer.imageBuffer else {
//            print("NO PIXEL BUFFER")
            return nil
        }
//        print("VIDEO DATA READED SUCCESSFULY")
        return .passRetained(pixelBuffer)
    }
    
    
}
