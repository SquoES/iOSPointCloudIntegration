//
//  TellAboutMeViewModel.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 06.10.2021.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa

class TellAboutMeViewModel: ViewModel {
    
    let photo = BehaviorRelay<UIImage?>(value: nil)
    let name = BehaviorRelay<String?>(value: nil)
    let aboutYourself  = BehaviorRelay<String?>(value: nil)
    let aboutYourselfCharactersLimit = Observable.just(IntFormatter.toMaxSymbolsCountFormat(Constants.kAboutYourselfCharactersLimit))
    
    let close = PublishSubject<Void>()
    let editPhoto = PublishSubject<Void>()
    let save = PublishSubject<Void>()
    
    override func subscribe() {
        close.bind(onNext: {
            Navigator.dismiss()
            Navigator.navigate(route: MainRoute.tabBar)
        }).disposed(by: disposeBag)
        
        editPhoto.bind(onNext: { [weak self] in
            self?.editPhotoAction()
        }).disposed(by: disposeBag)
        
        save.bind(onNext: { [weak self] in
            self?.saveAction()
        }).disposed(by: disposeBag)
    }
    
    private func editPhotoAction() {
        AlertConstructor(title: .empty,
                         message: Constants.kChooseImageSourceAlertMessage,
                         style: .actionSheet)
            .add(alertItems: .takePhoto, .openGallery, .cancel)
            .selectedAlertItem()
            .subscribe(onSuccess: { [weak self] alertItem in
                switch alertItem {
                case .takePhoto:
                    self?.openCameraAction()
                case .openGallery:
                    self?.openLibraryAction()
                default:
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    private func openCameraAction() {
        MediaPickerConstructor(sourceType: .camera)
            .show()
            .do(onSuccess: { [weak self] media in
                self?.handleMediaPickerConstructorOnSuccessAction(media)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func openLibraryAction() {
        MediaPickerConstructor(sourceType: .photoLibrary)
            .show()
            .do(onSuccess: { [weak self] media in
                self?.handleMediaPickerConstructorOnSuccessAction(media)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func handleMediaPickerConstructorOnSuccessAction(_ media: MediaPickerConstructor.Media) {
        switch media {
        case let .image(url):
            photo.accept(UIImage(contentsOfFile: url.path))
        case let .uiimage(image):
            photo.accept(image)
        default:
            break
        }
    }
    
    private func saveAction() {
        let fullname = name.value
        let about = aboutYourself.value
        
        var savingSingle: Single<Void>
        
        if let imageURL = photo.value?.saveToTempDirectory() {
            savingSingle = UploadImage.default.use(input: .init(fileURL: imageURL))
                .flatMap({ output in
                    EditProfile.default.use(input: .init(fullname: fullname,
                                                         avatarID: output.file?.id,
                                                         about: about))
                })
        } else {
            savingSingle = EditProfile.default.use(input: .init(fullname: fullname,
                                                                avatarID: nil,
                                                                about: about))
        }
        
        savingSingle.do(onSubscribed: { [weak self] in
            self?.isLoading.onNext(true)
        }, onDispose: { [weak self] in
            self?.isLoading.onNext(false)
        }).subscribe(onSuccess: {
            Navigator.dismiss()
            Navigator.navigate(route: MainRoute.tabBar)
        }, onError: { [weak self] error in
            self?.handleError(error)
        }).disposed(by: disposeBag)
    }
    
}

private enum Constants {
    static let kAboutYourselfCharactersLimit = 200
    
    static let kChooseImageSourceAlertMessage = "Choose image source"
}
