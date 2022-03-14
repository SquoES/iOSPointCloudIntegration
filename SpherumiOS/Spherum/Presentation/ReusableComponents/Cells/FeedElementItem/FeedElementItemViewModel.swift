import Foundation
import RxSwift
import RxCocoa
import RxMVVM

class FeedElementItemViewModel: ViewModel {
    
    private let userID: Int?
    
    let hideFollowButton: Observable<Bool>
    
    let realmFeedElement: RealmFeedElement
    
    lazy var viewsCount = realmFeedElement.rx.observe(\RealmFeedElement.views).map(IntFormatter.toAbbreviatedLargeNumberFormat(_:))
    let sharesCount = Observable.just(IntFormatter.toAbbreviatedLargeNumberFormat(0))
    
    lazy var imageURL = realmFeedElement.rx.observe(\RealmFeedElement.preview!.sourceURL).map { $0?.url }
    
    lazy var userName = realmFeedElement.rx.observe(\RealmFeedElement.user!.fullName)
    lazy var userAvatarURL = realmFeedElement.rx.observe(\RealmFeedElement.user!.avatar!.sourceURL).map { $0?.url }
    
    lazy var createdAt = realmFeedElement.rx.observe(\RealmFeedElement.created).map { $0?.date(using: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ")?.string(withFormat: "dd.MM.yyyy, HH:mm") } // FIXME: !!!
    
    let isFollowing = BehaviorRelay<Bool>(value: false)
    let like = BehaviorRelay<Bool>(value: false)
    let likes = BehaviorRelay<Int>(value: 0)
    lazy var likesString = likes.map(IntFormatter.toAbbreviatedLargeNumberFormat(_:))
        
    let switchIsFollowing = PublishSubject<Void>()
    let switchLike = PublishSubject<Void>()
    let openUser = PublishSubject<Void>()
    
    init(realmFeedElement: RealmFeedElement) {
        self.userID = realmFeedElement.user?.id
        self.realmFeedElement = realmFeedElement
        self.hideFollowButton = .just(realmFeedElement.user?.id == UserPropertiesManager.instance.userID)
    }
    
    override func subscribe() {
        switchIsFollowing
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] in
            guard let userID = self?.userID else {
                return
            }
            self?.invokeSingle(SwitchSubscribedToUser.default,
                               input: .init(userID: userID))
        }).disposed(by: disposeBag)
        
        if let userID = userID {
            invokeObservable(IsSubscribedToUser.default, input: .init(userID: userID)) { [weak self] output in
                self?.isFollowing.accept(output.subscribed)
            }
        }
        
        switchLike.bind(onNext: { [weak self] in
            self?.switchLikeAction()
        }).disposed(by: disposeBag)
        
        realmFeedElement.rx.observe(\RealmFeedElement.isLiked)
            .unwrap().bind(to: like).disposed(by: disposeBag)
        
        likes.accept(realmFeedElement.likedBy.count)
        
        openUser.bind(onNext: { [weak self] in
            guard let userID = self?.userID else {
                return
            }
            Navigator.navigate(route: ProfileRoute.profile(userID: userID))
        }).disposed(by: disposeBag)        
        
        super.subscribe()
    }
    
    private func switchLikeAction() {
        
        self.like.toggle()
        self.likes.accept(self.like.value ? self.likes.value + 1 : self.likes.value - 1)
        
        self.invokeSingle(SwitchFeedLike.default, input: .init(feedID: realmFeedElement.id))
    }
    
}
