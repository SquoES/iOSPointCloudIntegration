import UIKit
import RxMVVM

class CategoryItemCollectionViewCell: CollectionViewCell<CategoryItemViewModel> {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func bind(viewModel: CategoryItemViewModel) {
        
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
