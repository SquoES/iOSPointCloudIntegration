import UIKit
import RxMVVM

class FeedElementItemCollectionViewCell: CollectionViewCell<FeedElementItemViewModel> {

    @IBOutlet weak var imageView: UIImageView!
    
    override func bind(viewModel: FeedElementItemViewModel) {
        
        
        viewModel.imageURL.bind(to: imageView.rx.imageURL).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }

}
