import Foundation

extension URLSession {
    
    func requestDecodable<D: Decodable>(for urlRequest: URLRequest) async throws -> D {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let result = try jsonDecoder.decode(D.self, from: data)
                        continuation.resume(returning: result)
                    } catch let error {
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func requestFile(for urlRequest: URLRequest,
                     fileManager: FileManager,
                     destinationURL: URL) async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.downloadTask(with: urlRequest) { url, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url {
                    #if DEBUG
                    print("FILE DOWNLOADED TO:", url)
                    #endif
                    do {
                        try fileManager.moveItem(at: url, to: destinationURL)
                        #if DEBUG
                        print("FILE MOVED TO:", destinationURL)
                        #endif
                        continuation.resume(returning: ())
                    } catch let error {
                        #if DEBUG
                        print("FILE DOWNLOADING ERROR:", error)
                        #endif
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
