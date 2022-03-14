import UIKit
import RxMVVM

class LoadingItemTableViewCell: TableViewCell<LoadingItemViewModel> {

    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    
    override func bind(viewModel: LoadingItemViewModel) {
        
        viewModel.loading.bind(to: loadingIndicatorView.rx.isAnimating).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
