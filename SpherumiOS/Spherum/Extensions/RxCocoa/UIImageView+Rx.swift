import UIKit
import RxCocoa
import RxSwift
import Kingfisher

extension Reactive where Base: UIImageView {
    
    var imageURL: Binder<URL?>{
        return Binder<URL?>(base.self, binding: { view, imageURL in
            view.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
        })
    }
    
}
