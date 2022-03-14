import Foundation
import RxSwift

protocol FilesRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func uploadImage(imageURL: URL) -> Single<MediaFile?>
    func uploadImage(image: UIImage?) -> Single<MediaFile?>
    
    func getFile(fileID: Int) -> Single<MediaFile?>
    
    func downloadPackage(realmMediaFile: RealmMediaFile) -> Observable<VideoPackageProgress>
    
    func createPresignURL(filename: String, parentType: MediaFile.ParentType) -> Single<PresignMediaFileURL>
    func uploadFile(fileURL: URL, presignMediaFileURL: PresignMediaFileURL) -> Single<Void>
    func confirmUpload(id: String) -> Single<Void>
    
}
