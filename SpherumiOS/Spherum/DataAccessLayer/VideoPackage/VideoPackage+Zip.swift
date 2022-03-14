import ZIPFoundation
import Foundation

extension VideoPackage {
    
    func createZip() throws -> URL {
        let zipURL = zipURL!
        let folderURL = folderURL!
        
        if FileManager.default.fileExists(atPath: zipURL.path) {
            try FileManager.default.removeItem(at: zipURL)
        }
        
        let progress = Progress()
        let observation = progress.observe(\.completedUnitCount, changeHandler: { progress, completedUnitCount in
            print("zip:", Float(completedUnitCount.newValue ?? 0) / Float(progress.totalUnitCount))
        })
        try FileManager.default.zipItem(at: folderURL, to: zipURL, progress: progress)
        observation.invalidate()
        
        return zipURL
    }
    
}
