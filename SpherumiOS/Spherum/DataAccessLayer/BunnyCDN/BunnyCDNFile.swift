struct BunnyCDNFile: Decodable {
    
    let Path: String
    let ObjectName: String
    let IsDirectory: Bool
    
    var isInfoFile: Bool {
        ObjectName.lowercased() == "info.txt"
    }
    
    var isPreviewFile: Bool {
        ObjectName.lowercased() == "preview.jpg"
    }
    
}
