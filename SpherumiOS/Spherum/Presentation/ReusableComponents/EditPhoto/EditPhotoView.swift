//
//  EditPhotoView.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 06.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class EditPhotoView: XibView {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    @IBInspectable var photo: UIImage? = nil {
        didSet {
            updatePhotoImageView(photo)
        }
    }
    
    private func updatePhotoImageView(_ photo: UIImage?) {
        photoImageView.image = photo
        photoImageView.isHidden = photo == nil
    }
    
    override func loadUI() {
        super.loadUI()
        
        self.photoImageView.isHidden = true
    }
}

extension Reactive where Base: EditPhotoView {
    var photo: Binder<UIImage?> {
        Binder(self.base) { view, photo in
            view.photo = photo
        }
    }
    
    var editPhotoButtonTap: ControlEvent<Void> {
        self.base.editPhotoButton.rx.tap
    }
}
