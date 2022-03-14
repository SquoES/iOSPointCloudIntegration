import UIKit
import RxSwift
import RxMVVM

class LiveItemCollectionViewCell: CollectionViewCell<LiveItemViewModel> {
    
    @IBOutlet weak var tagView: TagView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var liveTitleLabel: UILabel!
    

    override func bind(viewModel: LiveItemViewModel) {
        
        viewModel.title.bind(to: liveTitleLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.imageURL.bind(to: liveImageView.rx.imageURL).disposed(by: reusableDisposeBag)
        
        viewModel.isRounded.bind(onNext: {[weak self] isRounded in
            self?.layer.cornerRadius = isRounded ? 12 : 0
        }).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }

}
