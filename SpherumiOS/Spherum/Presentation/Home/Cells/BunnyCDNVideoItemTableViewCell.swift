import UIKit
import RxSwift
import RxMVVM

class BunnyCDNVideoItemTableViewCell: TableViewCell<BunnyCDNVideoItemViewModel> {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func bind(viewModel: BunnyCDNVideoItemViewModel) {
        
        viewModel.previewImage.bind(to: previewImageView.rx.image).disposed(by: reusableDisposeBag)
        viewModel.title.bind(to: videoTitleLabel.rx.text).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
