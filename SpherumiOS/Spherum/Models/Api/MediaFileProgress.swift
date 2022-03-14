import Alamofire

enum MediaFileProgress<Result> {
    case uploading(progress: Double)
    case uploaded(data: Data)
    
    var progress: Double {
        switch self {
        case let .uploading(progress):
            return progress
            
        default:
            return 1.0
        }
    }
    
    var completed: Bool {
        progress >= 1.0
    }
    
}

extension MediaFileProgress where Result: Codable {
    
    func decodeData() throws -> Result {
        switch self {
        case let .uploaded(data):
            return try JSONDecoder().decode(Result.self, from: data)
            
        default:
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }
    }
    
}
