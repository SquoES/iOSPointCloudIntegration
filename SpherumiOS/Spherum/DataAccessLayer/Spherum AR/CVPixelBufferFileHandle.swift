import Foundation
import AVFoundation

final class CVPixelBufferFileHandle: NSObject {
    
    private(set) var sampleSize: Int = 0
    
    private let writing: Bool
    
    private let fileURL: URL
    private var fileHandle: FileHandle!
    
    private var fileSize: UInt64!
    
    private var fileClosed: Bool = false
    
    init(fileURL: URL, writing: Bool, sampleSize: Int = 0) {
        self.fileURL = fileURL
        self.sampleSize = sampleSize
        self.writing = writing
        
        super.init()

        createFileIfNotExist()

        self.fileHandle = writing ? try! FileHandle(forWritingTo: fileURL) : try! FileHandle(forReadingFrom: fileURL)
        
        fillFileSizeInfo()
    }
    
    func write(cvPixelBuffer: CVPixelBuffer) {
        guard !fileClosed else {
            return
        }
        
        let data = Data.from(pixelBuffer: cvPixelBuffer)
        sampleSize = data.count
        
        print("SAMPLE SIZE:", sampleSize)
        
        fileHandle.write(data)
    }
    
    func read(usingSampleInfo sampleInfo: SampleInfo, attributes: CFDictionary) -> CVPixelBuffer? {
        guard !fileClosed,
              let fileSize = fileSize,
              fileHandle.offsetInFile < fileSize else {
            return nil
        }
        
        let data = fileHandle.readData(ofLength: sampleSize)
        let cvPixelBuffer = CVPixelBuffer.from(data,
                                               width: sampleInfo.width,
                                               height: sampleInfo.height,
                                               pixelFormat: sampleInfo.pixelFormatType,
                                               attributes: attributes)
        
        
        
        return cvPixelBuffer
    }
    
    func finish() {
        fileClosed = true
        
        fileHandle.closeFile()
    }
    
    private func createFileIfNotExist() {
        if writing {
            if FileProvider.createFile(at: fileURL) {
                print("file at \(fileURL) created")
            } else {
                print("can't create file at \(fileURL)")
            }
        }
    }
    
    private func fillFileSizeInfo() {
        let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path)
        self.fileSize = attributes?[.size] as? UInt64
    }
    
}
