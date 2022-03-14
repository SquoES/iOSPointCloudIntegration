//
//  VideoDepthReader.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

class VideoDepthReader: NSObject {
    
    let depthFileURL: URL
    let depthMetaFileURL: URL
    
    private let depthFileHandle: FileHandle
    
    private var sampleSize: Int!
    private var fileSize: UInt64!
    private var baseDepthDataDictionaryRepresentaion: DepthMetaDictionaryRepresentaion!
    
    init(depthFileURL: URL, depthMetaFileURL: URL) throws {
        self.depthFileURL = depthFileURL
        self.depthMetaFileURL = depthMetaFileURL
        
        self.depthFileHandle = try FileHandle(forReadingFrom: depthFileURL)
        
        super.init()
        
        try self.fillBaseDepthDataDictionaryRepresentaion()
        try self.fillFileSizeInfo()
    }
    
    deinit {
        self.depthFileHandle.closeFile()
    }
    
    #if DEBUG
    var readedSamplesCount = 0
    #endif
    
    func readNextDepthData() -> AVDepthData? {
        guard let sampleSize = self.sampleSize,
              let fileSize = self.fileSize,
              self.depthFileHandle.offsetInFile < fileSize else {
            return nil
        }
        
        guard var dictionaryRepresentation = self.baseDepthDataDictionaryRepresentaion else {
            return nil
        }
        let nextData = self.depthFileHandle.readData(ofLength: sampleSize)
        dictionaryRepresentation[kCGImageAuxiliaryDataInfoData] = nextData as CFData
        
        guard let depthData = try? AVDepthData(fromDictionaryRepresentation: dictionaryRepresentation) else {
            return nil
        }
        
        #if DEBUG
        self.readedSamplesCount += 1
        print("READED SAMPLES COUNT:", self.readedSamplesCount)
        #endif
        
        return depthData
    }
    
    private func fillBaseDepthDataDictionaryRepresentaion() throws {
        let dataMetaData = try Data(contentsOf: self.depthMetaFileURL)
        let depthMeta = try JSONDecoder().decode(DepthMeta.self, from: dataMetaData)
        
        self.sampleSize = depthMeta.sampleSize
        
        self.baseDepthDataDictionaryRepresentaion = DepthMetaConverter.dictionaryRepresentation(from: depthMeta)
    }
    
    private func fillFileSizeInfo() throws {
        let attributes = try FileManager.default.attributesOfItem(atPath: self.depthFileURL.path)
        self.fileSize = attributes[.size] as? UInt64
    }
    
}
