import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ProfileHeaderView: BaseXibView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postCounterView: CounterView!
    @IBOutlet weak var followersCounterView: CounterView!
    @IBOutlet weak var followingCounterView: CounterView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: Button!
    @IBOutlet weak var followButton: Button!
    @IBOutlet weak var messageButton: Button!
    
    private var disposeBag = DisposeBag()
    private var profile: RealmUserRetrieve!
        
    fileprivate var isMe: Bool = true {
        didSet {
            self.changeViewType()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        avatarImageView.layer.cornerRadius = 16
        
    }
    
    fileprivate func upgradeProfile(_ profile: RealmUserRetrieve?) {
        guard let profile = profile else {
            return
        }
        self.profile = profile
        disposeBag = DisposeBag()
        
        profile.rx.observe(\RealmUserRetrieve.fullName).bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.feedElementsCount).bind(to: postCounterView.rx.value).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.about).bind(to: aboutLabel.rx.text).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.about).map({ $0?.isEmpty ?? true}).bind(to: aboutLabel.rx.isHidden).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.avatar).map({ URL(string: $0??.sourceURL ?? "" ) })
            .bind(to: avatarImageView.rx.imageURL).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.followersCount).bind(to: followersCounterView.rx.value).disposed(by: disposeBag)
        profile.rx.observe(\RealmUserRetrieve.followingsCount).bind(to: followingCounterView.rx.value).disposed(by: disposeBag)

        followButton.rx.tap.bind(onNext: {[weak self] in
            self?.switchFollowAction()
        }).disposed(by: disposeBag)
        
        IsSubscribedToUser.default.use(input: .init(userID: profile.id))
            .map({ $0.subscribed })
            .bind(to: followButton.rx.isSelected)
            .disposed(by: disposeBag)
        
    }
    
    private func switchFollowAction() {
        
        SwitchSubscribedToUser.default.use(input: .init(userID: profile.id))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func changeViewType() {
        editProfileButton.isHidden = !isMe
        followButton.isHidden = isMe
//        messageButton.isHidden = isMe
    }
    
}

extension Reactive where Base: ProfileHeaderView {
            
    var profile: Binder<RealmUserRetrieve?> {
        return Binder<RealmUserRetrieve?>(base.self, binding: {view, profile in
            view.upgradeProfile(profile)
        })
    }
    
    var isMe: Binder<Bool>{
        return Binder<Bool>(base.self, binding: {view, isMe in
            view.isMe = isMe
        })
    }
    
    var editProfile: ControlEvent<Void> {
        return base.editProfileButton.rx.tap
    }
    
}
