import UIKit
import RxSwift
import RxMVVM

class RecordTypeItemCollectionViewCell: CollectionViewCell<RecordTypeItemViewModel> {

    @IBOutlet weak var recordTypeImageView: UIImageView!
    
    override func bind(viewModel: RecordTypeItemViewModel) {
        
        recordTypeImageView.image = viewModel.recordType.image
        
        super.bind(viewModel: viewModel)
    }

}
