import Foundation

class BunnyProvider {
    
    private let session = URLSession(configuration: .default)
    private let fileManager = FileManager.default
    
    static let instance = BunnyProvider()
    
    func downloadAllFiles(forVideoGroup videoGroup: BunnyCDNVideoGroup, progress: Progress? = nil) async throws {
        let files = videoGroup.getOnlyFiles()
        
        let notDownloadedFiles = files.filter { !isFileAlreadyDownloaded($0) }
        
        if notDownloadedFiles.isEmpty {
            progress?.totalUnitCount = 1
            progress?.completedUnitCount = 1
        } else {
            progress?.totalUnitCount = Int64(files.count)
            
            var completedFiles = Int64(files.count - notDownloadedFiles.count)
            progress?.completedUnitCount = completedFiles
            
            for file in notDownloadedFiles {
                try await downloadFile(file)
                completedFiles += 1
                progress?.completedUnitCount = completedFiles
            }
        }
    }
    
    func prepareAndDownloadStudioVideos() async -> [BunnyCDNVideoGroup]? {
        guard let groups = await getAllVideoGroups() else {
            return nil
        }
        
        do {
            try await downloadAllPreviews(videoGroups: groups)
            return groups
        } catch {
            return nil
        }
    }
    
    func getInfo(forVideoGroup videoGroup: BunnyCDNVideoGroup) -> BunnyCDNVideoGroupInfo? {
        guard let infoFile = videoGroup.getInfoFile() else {
            return nil
        }
        
        guard let localFileURL = getLocalFileURL(for: infoFile) else {
            return nil
        }
        
        
        guard let data = try? Data(contentsOf: localFileURL),
              let videoInfo = try? JSONDecoder().decode(BunnyCDNVideoGroupInfo.self, from: data) else {
            return nil
        }
        
        return videoInfo
    }
    
    func cancelAllTasks() async {
        await session.allTasks.forEach {
            $0.cancel()
        }
    }
    
    func getLocalFolderURL(for file: BunnyCDNFile) -> URL? {
        var localFolderURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        localFolderURL?.appendPathComponent("CloudsBinary")
        let path = file.Path.replacingOccurrences(of: "/\(BunnyCDNConstants.storageName)/\(BunnyCDNConstants.folderName)/", with: "")
        localFolderURL?.appendPathComponent(path)
        return localFolderURL
    }
    
    func getLocalFileURL(for file: BunnyCDNFile) -> URL? {
        var localFileURL = getLocalFolderURL(for: file)
        localFileURL?.appendPathComponent(file.ObjectName)
        return localFileURL
    }
    
}

private extension BunnyProvider {
    
    func getAllVideoGroups() async -> [BunnyCDNVideoGroup]? {
        var groups: [BunnyCDNVideoGroup]
        
        do {
            let folders = try await getListOfRemoteFiles()
            groups = folders.map { BunnyCDNVideoGroup(mainFolder: $0) }
            
            for (index, folder) in folders.enumerated() {
                guard let innerFiles = await getFilesRecursively(forBunnyFolder: folder) else {
                    return nil
                }
                groups[index].addFiles(innerFiles)
            }
        } catch {
            return []
        }
        
        return groups
    }
    
    
    
    func downloadAllPreviews(videoGroups: [BunnyCDNVideoGroup]) async throws {
        let filesToDownload = videoGroups.reduce([]) { result, next in
            return result + [
                next.getInfoFile(),
                next.getPreviewFile()
            ].compactMap { $0 }
        }
        
        for file in filesToDownload {
            try await downloadFile(file)
        }
    }
    
    private func isFileAlreadyDownloaded(_ file: BunnyCDNFile) -> Bool {
        guard let localFileURL = getLocalFileURL(for: file) else {
            return false
        }
        return fileManager.fileExists(atPath: localFileURL.path)
    }
    
    private func getFilesRecursively(forBunnyFolder folder: BunnyCDNFile) async -> [BunnyCDNFile]? {
        var files = [BunnyCDNFile]()
        
        guard folder.IsDirectory else {
            return files
        }
        
        do {
            let path = folder.Path + folder.ObjectName
            let filesList = try await getListOfRemoteFiles(at: path)
            files.append(contentsOf: filesList)
            
            for file in filesList {
                guard let innerFilesList = await getFilesRecursively(forBunnyFolder: file) else {
                    return nil
                }
                
                files.append(contentsOf: innerFilesList)
            }
        } catch {
            return nil
        }
        
        return files
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue(BunnyCDNConstants.accessKey,
                         forHTTPHeaderField: "AccessKey")
        return request
    }
    
    private func getListOfRemoteFiles(at path: String? = nil) async throws -> [BunnyCDNFile] {
        var url = URL(string: BunnyCDNConstants.domain)!

        if let path = path {
            url.appendPathComponent(path + "/")
        } else {
            url.appendPathComponent(BunnyCDNConstants.storageName)
            url.appendPathComponent(BunnyCDNConstants.folderName + "/")
        }
        
        let request = createRequest(url: url)

        let files: [BunnyCDNFile] = try await session.requestDecodable(for: request)
        return files
    }
    
    private func downloadFile(_ file: BunnyCDNFile) async throws {
        var url = URL(string: BunnyCDNConstants.domain)!
        url.appendPathComponent(file.Path)
        url.appendPathComponent(file.ObjectName)
        
        guard let localFolderURL = getLocalFolderURL(for: file) else {
            return
        }
        
        if !fileManager.fileExists(atPath: localFolderURL.path) {
            try fileManager.createDirectory(at: localFolderURL,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
        }
        
        guard let localFileURL = getLocalFileURL(for: file) else {
            return
        }
        
        guard !fileManager.fileExists(atPath: localFileURL.path) else {
            return
        }
        
        let request = createRequest(url: url)
        
        try await session.requestFile(for: request,
                                      fileManager: fileManager,
                                      destinationURL: localFileURL)
    }
    
}
