


import UIKit
import RxMVVM

class HomeItemTableViewCell: TableViewCell<HomeItemViewModel> {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var followButton: Button!
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var lookIn3DButton: Button!
    
    @IBOutlet weak var likeButton: Button!
    @IBOutlet weak var viewsButton: Button!
    @IBOutlet weak var reposetButton: Button!
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 12
        avatarImageView.clipsToBounds = true
        
    }
    
    override func bind(viewModel: HomeItemViewModel) {
        
        followButton.rx.tap.bind(to: viewModel.followPressed).disposed(by: reusableDisposeBag)
        likeButton.rx.tap.bind(to: viewModel.likePressed).disposed(by: reusableDisposeBag)
        
        viewModel.isFollow.bind(to: followButton.rx.isSelected).disposed(by: reusableDisposeBag)
        viewModel.isLike.bind(to: likeButton.rx.isSelected).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
