import Foundation
import RxMVVM
import RxSwift
import RxCocoa

class EditProfileViewModel: ViewModel {
    
    let userName = BehaviorRelay<String?>(value: nil)
    let fullName = BehaviorRelay<String?>(value: nil)
    let about = BehaviorRelay<String?>(value: nil)
    let avatarURL = BehaviorRelay<URL?>(value: nil)
    
    private let newAvatarID = BehaviorRelay<Int?>(value: nil)
    
    let saveProfile = PublishSubject<Void>()
    let editPhotoPressed = PublishSubject<Void>()
        
    override func subscribe() {
        
        GetMyProfile.default.use().take(1)
            .bind(onNext: {[weak self] output in
                let profile = output.profile
                self?.userName.accept(profile?.username)
                self?.fullName.accept(profile?.fullName)
                self?.about.accept(profile?.about)
                self?.avatarURL.accept(URL(string: profile?.avatar?.imgFile ?? ""))
            }).disposed(by: disposeBag)
        
        saveProfile.bind(onNext: {[weak self] in
            self?.saveProfileAction()
        }).disposed(by: disposeBag)
        
        editPhotoPressed.bind(onNext: {[weak self] in
            self?.editPhotoAtction()
        }).disposed(by: disposeBag)
        
        
        super.subscribe()
    }
    
    private func saveProfileAction() {
        
        self.invokeSingle(EditProfile.default,
                          input: .init(fullname: fullName.value,
                                       avatarID: newAvatarID.value,
                                       about: about.value),
                          onCompleted: {  Navigator.pop() })
        
    }
    
    private func editPhotoAtction() {
        
        AlertConstructor(title: nil, message: nil, style: .actionSheet)
            .add(alertItem: .takePhoto, actionStyle: .default)
            .add(alertItem: .openGallery, actionStyle: .default)
            .add(alertItem: .cancel, actionStyle: .cancel)
            .selectedAlertItem()
            .subscribe(onSuccess: {[weak self] item in
                
                switch item {
                case .takePhoto: self?.createPhoto(.camera)
                case .openGallery: self?.createPhoto(.photoLibrary)
                default: break
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    private func createPhoto(_ sourceType: UIImagePickerController.SourceType){
        
        MediaPickerConstructor(sourceType: sourceType)
            .show()
            .subscribe(onSuccess: {[weak self] media in
                
                switch media {
                case let .image(url): self?.uploadImage(url: url)
                case let .uiimage(image):
                    guard let url = image.saveToTempDirectory() else { return }
                    self?.uploadImage(url: url)
                default: break
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    private func uploadImage(url: URL) {
        self.invokeSingle(UploadImage.default,
                          input: .init(fileURL: url),
                          onCompleted: {[weak self] output in
            self?.newAvatarID.accept(output.file?.id)
            self?.avatarURL.accept(output.file?.imgFileURL)
        })
    }
}
