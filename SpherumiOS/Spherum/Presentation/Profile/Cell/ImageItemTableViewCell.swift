import UIKit
import RxMVVM

class ImageItemTableViewCell: TableViewCell<ImageItemViewModel> {

    @IBOutlet weak var contentImageView: UIImageView!
    
    override func bind(viewModel: ImageItemViewModel) {
        
        
        super.bind(viewModel: viewModel)
    }
 
    
    
}
