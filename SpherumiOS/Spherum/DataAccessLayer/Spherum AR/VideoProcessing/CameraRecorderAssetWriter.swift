//
//  CameraRecorderAssetWriter.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 20.06.2021.
//

import Foundation
import AVFoundation

class CameraRecorderAssetWriter: NSObject {
    
    private let videoSettings: [String: Any]
    
    private var baseVideoAssetWriter: AVAssetWriter!
    private var baseVideoAssetWriterInput: AVAssetWriterInput!
    
    private var videoDepthWriter: VideoDepthWriter!
    
    private var needToPrepare = true
    private var preparingFailed = false
    private var recordStarted = false
    private var sessionStarted = false
    
    private let processingQ = DispatchQueue(label: "CameraRecorderAssetWriter_compression",
                                            qos: .userInteractive)
    
    private let fileGroup = FileProvider.createFileGroup(basedOn: .nowDate)
    
    init(recommendedVideoSettings: [AnyHashable: Any]?) {
        self.videoSettings = recommendedVideoSettings as? [String: Any] ?? [:]
    }
    
    func record(videoData: AVCaptureSynchronizedSampleBufferData?, depthData: AVCaptureSynchronizedDepthData?) {
        guard recordStarted,
              !self.preparingFailed,
              let depthData = depthData,
              let videoData = videoData else {
            return
        }
                
        guard !videoData.sampleBufferWasDropped,
              !depthData.depthDataWasDropped else {
            return
        }
        
        let timestamp = depthData.timestamp
        
        if !sessionStarted {
            self.sessionStarted = true
            self.baseVideoAssetWriter.startSession(atSourceTime: timestamp)
        }
        
        if self.baseVideoAssetWriterInput.isReadyForMoreMediaData {
            if self.baseVideoAssetWriterInput.append(videoData.sampleBuffer) {
                #if DEBUG
                print("CameraRecorderAssetWriter: base writed")
                #endif
            } else {
                #if DEBUG
                print("CameraRecorderAssetWriter: base not writed")
                #endif
            }
        } else {
            #if DEBUG
            print("CameraRecorderAssetWriter: base input not ready")
            #endif
        }
        
        self.videoDepthWriter.add(depthData: depthData.depthData)
    }
    
    func stopRecording(onCompleted: @escaping (FileGroup) -> Void) {
        self.videoDepthWriter.finish()
        self.baseVideoAssetWriterInput.markAsFinished()
        
        self.baseVideoAssetWriter.finishWriting(completionHandler: {
            #if DEBUG
            print("CameraRecorderAssetWriter: base writing finished")
            #endif
            onCompleted(self.fileGroup) // FIXME: - Возможна утечка
        })
        
    }
    
    func startRecording() {
        guard !self.recordStarted else {
            return
        }
        
        self.prepareIfNeeded()
        
        if self.baseVideoAssetWriter.startWriting() {
            #if DEBUG
            print("CameraRecorderAssetWriter: base writing started")
            #endif
        } else {
            #if DEBUG
            print("CameraRecorderAssetWriter: base writing error - \(self.baseVideoAssetWriter.error?.localizedDescription ?? "")")
            #endif
            
        }
        
        self.recordStarted = true
    }
    
    private func prepareIfNeeded() {
        guard self.needToPrepare,
              !self.preparingFailed else {
            return
        }
        
        do {
            try self.setupInputs()
        } catch let error {
            #if DEBUG
            print("CameraRecorderAssetWriter: \(error.localizedDescription)")
            #endif
            
            self.preparingFailed = true
        }
        
        needToPrepare = false
    }
    
    private func setupInputs() throws {
        
        self.baseVideoAssetWriterInput = AVAssetWriterInput(mediaType: .video,
                                                            outputSettings: self.videoSettings)
        self.baseVideoAssetWriter = try AVAssetWriter(outputURL: self.fileGroup.movURL,
                                                      fileType: .mov)
        self.baseVideoAssetWriter.add(self.baseVideoAssetWriterInput)
        
        self.videoDepthWriter = try VideoDepthWriter(depthFileURL: self.fileGroup.depthURL,
                                                     depthMetaFileURL: self.fileGroup.depthMetaURL)
    }
    
}
