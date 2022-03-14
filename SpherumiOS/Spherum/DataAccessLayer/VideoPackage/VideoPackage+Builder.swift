extension VideoPackage {
    
    private static func createURL(basedOn date: Date,
                                  prefix: String,
                                  ext: String) -> URL {
        let dataHash = abs(Int(date.timeIntervalSince1970))
        
        var url = URL(fileURLWithPath: NSTemporaryDirectory())
        
        let folderName = dataHash.toString()
        url.appendPathComponent(folderName)
        
        let fileName = "\(prefix)_\(dataHash).\(ext)"
        url.appendPathComponent(fileName)
        
        return url
    }
    
    static func createModelPackage() -> VideoPackage {
        let date = Date()
        let prefix = "create_model"
        return .createModel(createURL(basedOn: date,
                                      prefix: prefix,
                                      ext: "mov"))
    }
    
    static func faceIDPackage() -> VideoPackage {
        let date = Date()
        let prefix = "face_id"
        return .faceID(colorURL: createURL(basedOn: date,
                                           prefix: prefix,
                                           ext: "mov"),
                       depthURL: createURL(basedOn: date,
                                           prefix: prefix,
                                           ext: "depth"),
                       depthMetaURL: createURL(basedOn: date,
                                               prefix: prefix,
                                               ext: "depthmeta"))
    }
    
    static func lidarPackage() -> VideoPackage {
        let date = Date()
        let prefix = "lidar"
        return .lidar(colorURL: createURL(basedOn: date,
                                          prefix: prefix,
                                          ext: "mov"),
                      depthURL: createURL(basedOn: date,
                                          prefix: prefix,
                                          ext: "depth"),
                      confidenceURL: createURL(basedOn: date,
                                               prefix: prefix,
                                               ext: "confidence"))
    }
    
    static func create(from folder: URL) -> VideoPackage? {
        let paths = (try? FileManager.default.contentsOfDirectory(atPath: folder.path)) ?? []
        
        print("PATHS:", paths)
        
        let mov = paths.first(where: { $0.contains(".mov") })
        let depth = paths.first(where: { $0.components(separatedBy: ".").last == "depth" })
        let depthmeta = paths.first(where: { $0.components(separatedBy: ".").last == "depthmeta" })
        let confidence = paths.first(where: { $0.contains(".confidence") })
        
        if let mov = mov {
            let movURL = folder.appendingPathComponent(mov)
            
            if let depth = depth {
                let depthURL = folder.appendingPathComponent(depth)
                
                if let depthmeta = depthmeta {
                    let depthmetaURL = folder.appendingPathComponent(depthmeta)
                    
                    return .faceID(colorURL: movURL,
                                   depthURL: depthURL,
                                   depthMetaURL: depthmetaURL)
                }
                
                if let confidence = confidence {
                    let confidenceURL = folder.appendingPathComponent(confidence)
                    
                    return .lidar(colorURL: movURL,
                                  depthURL: depthURL,
                                  confidenceURL: confidenceURL)
                }
            }
            
            return .video2D(movURL)
        }
        
        return nil
    }
    
}
