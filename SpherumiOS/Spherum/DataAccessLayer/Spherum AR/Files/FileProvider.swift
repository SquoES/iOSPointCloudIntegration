//
//  FileProvider.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

class FileProvider: NSObject {
    
    static let fileManager = FileManager.default
    
    static let rootDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
    
    static func createFileGroup(basedOn nameBase: FileGroupNameBase) -> FileGroup {
        let filenameBase = nameBase.filename
        
        return FileGroup(movURL: createFilename(withBase: filenameBase, fileType: .mov),
                         depthURL: createFilename(withBase: filenameBase, fileType: .depth),
                         depthMetaURL: createFilename(withBase: filenameBase, fileType: .depthMeta))
    }
    
    static func createFile(at url: URL) -> Bool {
        return fileManager.createFile(atPath: url.path,
                                      contents: nil,
                                      attributes: nil)
    }
    
    private static func createFilename(withBase base: String, fileType: FileType) -> URL {
        let fullFilename = "\(base).\(fileType.fileExtension)"
        let fullFileURL =  rootDirectoryURL.appendingPathComponent(fullFilename)
        return fullFileURL
    }
    
}
