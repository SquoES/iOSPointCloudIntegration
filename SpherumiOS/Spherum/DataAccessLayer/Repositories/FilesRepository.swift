import Foundation
import RxSwift
import RxSwiftExt
import Alamofire
import RxAlamofireWrapper
import CleanMapper
import ZIPFoundation

class FilesRepository: FilesRepositoryProtocol {
    
    func uploadImage(imageURL: URL) -> Single<MediaFile?> {
        
        let formData = MultipartFormData()
        
        if let ciImage = CIImage(contentsOf: imageURL) {
            let jpegData = CIContext().jpegRepresentation(of: ciImage, colorSpace: CGColorSpaceCreateDeviceRGB())
            let fileName = imageURL.lastPathComponent.split(separator: ".").first?.appending(".jpeg") ?? "image.jpeg"
            formData.append(jpegData!, withName: "img_file", fileName: fileName)
        }
        
        return self.uploadRequest(ApiRouter.files, method: .post, formData: formData)
    }
    
    func uploadImage(image: UIImage?) -> Single<MediaFile?> {
        let formData = MultipartFormData()
        
        if let imageData = image?.pngData() {
            formData.append(imageData, withName: "img_file", fileName: "image.png", mimeType: "image/png")
        }
        
        return self.uploadRequest(ApiRouter.files,
                                  method: .post,
                                  formData: formData)
    }
    
    func getFile(fileID: Int) -> Single<MediaFile?> {
        self.request(ApiRouter.file(fileID: fileID), method: .get)
    }
    
    func downloadPackage(realmMediaFile: RealmMediaFile) -> Observable<VideoPackageProgress> {
        .create { observer in
            
            let fileName = realmMediaFile.sourceID
                
            if fileName.contains(".zip") {
                    
                let folderName = String(fileName.dropLast(4))
                    
                let localFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName)
                
                if FileManager.default.fileExists(atPath: localFolderURL.path) {
                    if let innerFolderName = (try? FileManager.default.contentsOfDirectory(atPath: localFolderURL.path))?.first {
                        if let videoPackage = VideoPackage.create(from: localFolderURL.appendingPathComponent(innerFolderName)) {
                            observer.onNext(.completed(videoPackage: videoPackage))
                        } else {
                            observer.onNext(.completed(videoPackage: .unknown))
                        }
                        observer.onCompleted()
                    }
                    
                } else if let remoteURL = realmMediaFile.sourceURL.url {
                    
                    return self.downloadFile(from: remoteURL, named: fileName, progressHandler: { progress in
                        observer.onNext(.downloading(progress: progress))
                    }).subscribe(onSuccess: { url in
                        if let url = url {
//                            let progress = Progress()
//                            var completedCount = 0
//                            let observation = progress.observe(\.completedUnitCount) { progress, _ in
//                                DispatchQueue.main.async {
//                                    let progress = VideoPackageProgress.unarchiving(progress: Double(completedCount) / Double(3))
//                                    completedCount += 1
//                                    print(progress)
//                                    observer.onNext(progress)
//                                }
//                            }
                            DispatchQueue.main.async {
                                observer.onNext(.unarchiving(progress: .zero))
                            }
                            
                            try! FileManager.default.unzipItem(at: url, to: localFolderURL)//, progress: progress)
                            
                            if let innerFolderName = (try? FileManager.default.contentsOfDirectory(atPath: localFolderURL.path))?.first {
                                if let videoPackage = VideoPackage.create(from: localFolderURL.appendingPathComponent(innerFolderName)) {
                                    observer.onNext(.completed(videoPackage: videoPackage))
                                } else {
                                    observer.onNext(.completed(videoPackage: .unknown))
                                }
                                observer.onCompleted()
                            }
                        } else {
                            observer.onNext(.completed(videoPackage: .unknown))
                            observer.onCompleted()
                        }
                    }, onError: { error in
                        observer.onError(error)
                    })
                    
                }
                
            } else if fileName.contains(".mov") || fileName.contains(".mp4") {
                
                let localMovURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: localMovURL.path) {
                    
                    observer.onNext(.completed(videoPackage: .video2D(localMovURL)))
                    observer.onCompleted()
                    
                } else if let remoteURL = realmMediaFile.sourceURL.url {
                    
                    return self.downloadFile(from: remoteURL, named: fileName, progressHandler: { progress in
                        observer.onNext(.downloading(progress: progress))
                    }).subscribe(onSuccess: { url in
                        if let url = url {
                            observer.onNext(.completed(videoPackage: .video2D(url)))
                        } else {
                            observer.onNext(.completed(videoPackage: .unknown))
                        }
                        observer.onCompleted()
                    }, onError: { error in
                        observer.onError(error)
                    })
                    
                }
                
            } else {
                observer.onNext(.completed(videoPackage: .unknown))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        
    }
    
    func createPresignURL(filename: String, parentType: MediaFile.ParentType) -> Single<PresignMediaFileURL> {
        let json: [String: Any] = [
            "filename": filename,
            "parent_type": parentType.rawValue
        ]
        let data: Single<Data> = self.request(ApiRouter.createPresignURL,
                                              method: .post,
                                              json: json)
        
        return data.map({ data in
            let dictionary = Self.dictionary(from: data)
            return PresignMediaFileURL(content: dictionary)
        })
    }
    
    func uploadFile(fileURL: URL, presignMediaFileURL: PresignMediaFileURL) -> Single<Void> {
        let formData = MultipartFormData()
        
        
        let keys = [
            "key",
            "x-amz-algorithm",
            "x-amz-credential",
            "x-amz-date",
            "policy",
            "x-amz-signature"
        ]
        for key in keys {
            if let data = presignMediaFileURL.requestFields[key]?.toData() {
                formData.append(data, withName: key)
            }
        }
        
        formData.append(fileURL, withName: "file")
        
        return self.uploadRequest(presignMediaFileURL.requestURL.lastPathComponent.contains("data") ? presignMediaFileURL.requestURL.deletingLastPathComponent() : presignMediaFileURL.requestURL,
                                  method: .post,
                                  formData: formData)
    }
    
    func confirmUpload(id: String) -> Single<Void> {
        self.request(ApiRouter.confirmUpload(id: id),
                     method: .post)
    }
    
}

private extension FilesRepository {
    
    static func dictionary(from data: Data) -> [String: Any] {
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
    
    private func postMedia(_ url: URLConvertible, formData: MultipartFormData) -> Observable<MediaFileProgress<MediaFile>> {
        .create { observer in
            return AlamofireWrapper.shared.uploadRequest(url,
                                                         method: .post,
                                                         formData: formData)
                .subscribe(onNext: { state in
                    switch state {
                    case let .uploading(_, progress):
                        observer.onNext(.uploading(progress: progress))
                        
                    case let .completed(_, data):
                        observer.onNext(.uploaded(data: data))
                        observer.onCompleted()
                    }
                }, onError: { error in
                    observer.onError(error)
                })
        }
    }
    
}
