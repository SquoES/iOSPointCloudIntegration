struct BunnyCDNVideoGroup {
    
    let mainFolder: BunnyCDNFile
    var files = [BunnyCDNFile]()
    
    mutating func addFiles(_ files: [BunnyCDNFile]) {
        self.files.append(contentsOf: files)
    }
    
    func getOnlyFiles() -> [BunnyCDNFile] {
        files.filter { !$0.IsDirectory }
    }
    
    func getPreviewFile() -> BunnyCDNFile? {
        files.first { $0.isPreviewFile }
    }
    
    func getInfoFile() -> BunnyCDNFile? {
        files.first { $0.isInfoFile }
    }
    
}
