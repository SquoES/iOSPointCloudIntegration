import UIKit
import RxSwift
import RxMVVM

class FeedElementItemTableViewCell: TableViewCell<FeedElementItemViewModel> {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var followButton: Button!
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var previewTagView: TagView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var sharesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.setImage(UIImage.likesIcon, for: .normal)
        likeButton.setImage(UIImage.likesIconSelected, for: .selected)
    }
    
    override func bind(viewModel: FeedElementItemViewModel) {
        
        viewModel.hideFollowButton.bind(to: followButton.rx.isHidden).disposed(by: reusableDisposeBag)
        
        viewModel.imageURL.bind(to: previewImageView.rx.imageURL).disposed(by: reusableDisposeBag)
        
        viewModel.userName.bind(to: usernameLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.userAvatarURL.bind(to: avatarImageView.rx.imageURL).disposed(by: reusableDisposeBag)
        
        viewModel.createdAt.bind(to: timeAgoLabel.rx.text).disposed(by: reusableDisposeBag)
        
        userButton.rx.tap.bind(to: viewModel.openUser).disposed(by: reusableDisposeBag)
        
        viewModel.isFollowing
            .bind(to: followButton.rx.isSelected)
            .disposed(by: reusableDisposeBag)
                
        viewModel.likesString.bind(to: likesCountLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.like.bind(to: likeButton.rx.isSelected).disposed(by: reusableDisposeBag)
        likeButton.rx.tap.bind(to: viewModel.switchLike).disposed(by: reusableDisposeBag)
        
        followButton.rx.tap
            .bind(to: viewModel.switchIsFollowing)
            .disposed(by: reusableDisposeBag)
        
        viewModel.viewsCount.bind(to: viewsCountLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.sharesCount.bind(to: sharesCountLabel.rx.text).disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
