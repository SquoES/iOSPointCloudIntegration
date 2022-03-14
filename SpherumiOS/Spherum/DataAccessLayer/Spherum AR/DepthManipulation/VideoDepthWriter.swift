//
//  VideoDepthRecorder.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

class VideoDepthWriter: NSObject {
    
    let depthFileURL: URL
    let depthMetaFileURL: URL
    
    private var depthFileHandle: FileHandle!
    
    private var depthSampleSize: Int!
    
    private var filesClosed = false
    
    private var depthMetaRecorded = false
    
    init(depthFileURL: URL, depthMetaFileURL: URL) throws {
        self.depthFileURL = depthFileURL
        self.depthMetaFileURL = depthMetaFileURL
        
        super.init()
        
        self.createFiles()
        
        self.depthFileHandle = try FileHandle(forWritingTo: depthFileURL)
    }
    
    func add(depthData: AVDepthData) {
        
        guard !self.filesClosed else {
            return
        }
        
        var auxiliaryDataType: NSString? = AVConstants.auxiliaryDataType
        
        guard let depthDataDictionaryRepresentaion = depthData.dictionaryRepresentation(forAuxiliaryDataType: &auxiliaryDataType) else {
            #if DEBUG
            print("DEPTH DATA SKIPPED")
            #endif
            return
        }
        
        self.recordDepthData(from: depthDataDictionaryRepresentaion)

        if !self.depthMetaRecorded {
            self.recordMeta(from: depthDataDictionaryRepresentaion)
        }
    }
    
    private func createFiles() {
        if FileProvider.createFile(at: self.depthFileURL) {
            print("file at \(self.depthFileURL) created")
        } else {
            print("can't create file at \(self.depthFileURL)")
        }
//        if FileProvider.createFile(at: self.depthMetaFileURL) {
//            print("file at \(self.depthMetaFileURL) created")
//        } else {
//            print("can't create file at \(self.depthMetaFileURL)")
//        }
    }
    
    #if DEBUG
    var recordedSamplesCount = 0
    #endif
    
    private func recordDepthData(from depthDataDictionaryRepresentaion: DepthMetaDictionaryRepresentaion) {
        guard let dataValue = depthDataDictionaryRepresentaion[kCGImageAuxiliaryDataInfoData] else {
            return
        }
        
        guard let data = dataValue as? NSData else { //,
//              let compressedData = try? data.compressed(using: AVConstants.dataCompressionAlgorithm) else {
            return
        }
        
        self.depthSampleSize = data.count
        print("data count:", data.count)
//        print("compressed data count:", compressedData.count)
        
        guard !self.filesClosed else {
            return
        }
        
//        self.depthFileHandle.seekToEndOfFile()
        self.depthFileHandle.write(data as Data)//write(compressedData as Data)
        #if DEBUG
        self.recordedSamplesCount += 1
        print("RECORDED SAMPLES COUNT:", self.recordedSamplesCount)
        #endif
    }
    
    private func recordMeta(from depthDataDictionaryRepresentaion: DepthMetaDictionaryRepresentaion) {
        guard let depthSampleSize = self.depthSampleSize else {
            return
        }
        print("kCVPixelFormatType_DepthFloat16:", kCVPixelFormatType_DepthFloat16) // 1751410032
        guard let depthMeta = DepthMetaConverter.depthMeta(from: depthDataDictionaryRepresentaion, depthSampleSize: depthSampleSize) else {
            return
        }
        guard let depthMetaJSON = try? JSONEncoder().encode(depthMeta) else {
            return
        }
        guard let depthMetaJSONString = String(data: depthMetaJSON, encoding: .utf8) else {
            return
        }
        
        try! depthMetaJSONString.write(to: self.depthMetaFileURL,
                                       atomically: true,
                                       encoding: .utf8)
        self.depthMetaRecorded = true
    }
    
    func finish() {
        guard !self.filesClosed else {
            return
        }
        
        self.filesClosed = true
        
        self.depthFileHandle.closeFile()
    }
    
}
