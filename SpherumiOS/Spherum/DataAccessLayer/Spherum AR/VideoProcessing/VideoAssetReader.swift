//
//  VideoAssetReader.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 24.06.2021.
//

import Foundation
import AVFoundation

class VideoAssetReader: NSObject {
    
    private let recordedVideoInfo: RecordedVideoInfo
    
    private var baseVideoAssetReader: AVAssetReader!
    private var baseVideoAssetReaderOutput: AVAssetReaderOutput!
    
    private var depthVideoAssetReader: AVAssetReader!
    private var depthVideoAssetReaderOutput: AVAssetReaderOutput!
    
    private var needToPrepare = true
    private var preparingFailed = false
    
    private let depthOutputSettings: [String: Any] = [
        kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_DisparityFloat16
    ]
    private let videoOutputSettings: [String: Any] = [
        kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
    ]
    
    init(recordedVideoInfo: RecordedVideoInfo) {
        self.recordedVideoInfo = recordedVideoInfo
        
        super.init()
        
        self.prepareIfNeeded()
    }
    
    func readNextSample() -> (CVPixelBuffer, AVDepthData)? {
        guard !self.preparingFailed else {
            return nil
        }
        
        guard let videoSampleBuffer = self.baseVideoAssetReaderOutput.copyNextSampleBuffer(),
              let videoPixelBuffer = CMSampleBufferGetImageBuffer(videoSampleBuffer) else {
            return nil
        }
        guard let depthSampleBuffer = self.depthVideoAssetReaderOutput.copyNextSampleBuffer(),
              let depthPixelBuffer = CMSampleBufferGetImageBuffer(depthSampleBuffer) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(depthPixelBuffer, .readOnly)
        let data = CVPixelBufferGetBaseAddress(depthPixelBuffer)
        let width = CVPixelBufferGetWidth(depthPixelBuffer)
        let height = CVPixelBufferGetHeight(depthPixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(depthPixelBuffer)
        let length = CVPixelBufferGetDataSize(depthPixelBuffer)
        let pixelFormat = CVPixelBufferGetPixelFormatType(depthPixelBuffer)
        
        let description: [AnyHashable: Any] = [
            "BytesPerRow": bytesPerRow,
            "PixelFormat": kCVPixelFormatType_DepthFloat32,
            "Width": width,
            "Height": height
        ]
        
        let dictionaryRepresitantion: [AnyHashable: Any] = [
            kCGImageAuxiliaryDataInfoData: NSData(bytes: data, length: length) as CFData,
            kCGImageAuxiliaryDataInfoDataDescription: description as CFDictionary
//            kCGImageAuxiliaryDataInfoMetadata: []
        ]

        do {
            let depthData = try AVDepthData(fromDictionaryRepresentation: dictionaryRepresitantion)
            CVPixelBufferUnlockBaseAddress(depthPixelBuffer, .readOnly)
            return (videoPixelBuffer, depthData)
        } catch let error {
            print(error.localizedDescription)
        }
        
        CVPixelBufferUnlockBaseAddress(depthPixelBuffer, .readOnly)

        return nil
    }
    
    private func prepareIfNeeded() {
        guard self.needToPrepare else {
            return
        }
        
        self.needToPrepare = false
        
        let baseVideoAsset = AVAsset(url: self.recordedVideoInfo.baseFileURL)
        do {
            self.baseVideoAssetReader = try AVAssetReader(asset: baseVideoAsset)
        } catch {
            self.preparingFailed = true
            return
        }
        guard let baseVideoTrack = baseVideoAsset.tracks(withMediaType: .video).first else {
            self.preparingFailed = true
            return
        }
        self.baseVideoAssetReaderOutput = AVAssetReaderTrackOutput(track: baseVideoTrack,
                                                                   outputSettings: self.videoOutputSettings)
        if self.baseVideoAssetReader.canAdd(self.baseVideoAssetReaderOutput) {
            self.baseVideoAssetReader.add(self.baseVideoAssetReaderOutput)
        } else {
            self.preparingFailed = true
            return
        }
        
        
        let depthVideoAsset = AVAsset(url: self.recordedVideoInfo.depthFileURL)
        do {
            self.depthVideoAssetReader = try AVAssetReader(asset: depthVideoAsset)
        } catch {
            self.preparingFailed = true
            return
        }
        guard let depthVideoTrack = depthVideoAsset.tracks(withMediaType: .video).first else {
            self.preparingFailed = true
            return
        }
        self.depthVideoAssetReaderOutput = AVAssetReaderTrackOutput(track: depthVideoTrack,
                                                                    outputSettings: self.videoOutputSettings)
        
        if self.depthVideoAssetReader.canAdd(self.depthVideoAssetReaderOutput) {
            self.depthVideoAssetReader.add(self.depthVideoAssetReaderOutput)
        } else {
            self.preparingFailed = true
            return
        }
        
        if !self.baseVideoAssetReader.startReading() {
            self.preparingFailed = true
            return
        }
        if !self.depthVideoAssetReader.startReading() {
            self.preparingFailed = true
            return
        }
    }
    
}
