struct PresignMediaFileURL {
    
    private let content: [String: Any]
    
    init(content: [String: Any]) {
        self.content = content
    }
    
    private var sourceFields: [String: Any] {
        content["source_fields"] as! [String: Any]
    }
    
    var id: Int {
        content["id"] as! Int
    }
    
    var requestURL: URL {
        (sourceFields["url"] as! String).url!
    }
    
    var requestFields: [String: String] {
        sourceFields["fields"] as! [String: String]
    }
    
}
