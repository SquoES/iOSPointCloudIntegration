import Foundation
import UIKit

extension URL {
    
    static func createMovURL(forFileNamed fileName: String) -> URL {
        let rootDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileNameWithExt = fileName + ".mov"
        let url = rootDirectoryURL.appendingPathComponent(fileNameWithExt)
        
        #if DEBUG
        print("FILE URL:", url)
        #endif
        
        return url
    }
    
    static func createFileURL(forFileNamed fileName: String) -> URL {
        let rootDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let url = rootDirectoryURL.appendingPathComponent(fileName)
        
        #if DEBUG
        print("FILE URL:", url)
        #endif
        
        return url
    }
    
    var filename: String? {
        return self.lastPathComponent.split(separator: ".").dropLast().joined(separator: ".")
    }
    
    static func temporaryURL(prefix: String = "", `extension`: String) -> URL? {
        let fileName = prefix + UUID().uuidString + "." + `extension`
        let tempDirectory = NSTemporaryDirectory() as NSString
        return URL(fileURLWithPath: tempDirectory.appendingPathComponent(fileName))
    }
    
    func createFoldersRecursively() {
        var folderURL = self
        
        if !folderURL.hasDirectoryPath {
            folderURL.deleteLastPathComponent()
        }
        
        try! FileManager.default.createDirectory(at: folderURL,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        
        #if DEBUG
        print("Folder created:", folderURL)
        #endif
    }
    
    func createVideoPreview(rotatedBy radians: Float? = nil) -> UIImage? {
        let asset = AVURLAsset(url: self)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        let time = CMTime(value: 0, timescale: 1)
        guard let cgImage = try? imgGenerator.copyCGImage(at: time, actualTime: nil) else {
            return nil
        }
        if let radians = radians {
            return UIImage(cgImage: cgImage).rotate(radians: radians)
        } else {
            return UIImage(cgImage: cgImage)
        }
    }
    
}

//MARK: - Mime type
extension URL {
    
    func mimeType() -> String {
        guard let type = self.lastPathComponent.split(separator: ".").last?.lowercased() else { return "application/octet-stream" }
        
        switch type {
        case "7z":
            return "application/x-7z-compressed"
        case "pdf":
            return "application/pdf"
        case "avi":
            return "video/x-msvideo"
        case "bmp":
            return "image/bmp"
        case "torrent":
            return "application/x-bittorrent"
        case "css":
            return "text/css"
        case "flv":
            return "video/x-flv"
        case "gif":
            return "image/gif"
        case "html":
            return "text/html"
        case "json":
            return "application/json"
        case "heic":
            return "image/heic"
        case "jpeg", "jpg":
            return "image/jpeg"
        case "m4v":
            return "video/x-m4v"
        case "xls", "xlsx":
            return "application/vnd.ms-excel"
        case "docx":
            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        case "doc":
            return "application/msword"
        case "mpeg":
            return "video/mpeg"
        case "mp4":
            return "video/mp4"
        case "webm":
            return "video/webm"
        case "psd":
            return "image/vnd.adobe.photoshop"
        case "png":
            return "image/png"
        case "rtf":
            return "application/rtf"
        case "svg":
            return "image/svg+xml"
        case "zip":
            return "application/zip"
        case "m4r":
            return "audio/mpeg"
        case "amr":
            return "audio/mpeg"
        case "m4a":
            return "audio/mpeg"
        case "mp2":
            return "audio/mpeg"
        case "wav":
            return "audio/mpeg"
        case "ogg":
            return "audio/mpeg"
        case "flac":
            return "audio/mpeg"
            
        default:
            return "application/octet-stream"
        }
    }
    
}
