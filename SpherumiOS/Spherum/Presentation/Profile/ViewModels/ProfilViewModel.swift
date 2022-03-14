import Foundation
import RxMVVM
import RxSwift
import RxCocoa
import RxDataSources

class ProfileViewModel: ViewModel {
    
    let profile: Observable<RealmUserRetrieve?>
    let isMyProfile: Observable<Bool>
    let feedElements: Observable<[RealmFeedElement]>
    
    lazy var firstName = profile.map({ $0?.username })
    
    private let typeContentView = BehaviorRelay<TypeContentView>(value: .collection)
    lazy var showCollectionView = typeContentView.map({ $0 == .collection })
    lazy var showTableView = typeContentView.map({ $0 == .list })
    
    let typeContentViewIndex = BehaviorRelay<Int>(value: 0)
    let contentHeight = BehaviorRelay<CGFloat>(value: 0)
    
    let willAppear = PublishSubject<Void>()
    
    let editProfile = PublishSubject<Void>()
    
    private let feedElementItemViewModels = BehaviorRelay<[FeedElementItemViewModel]>(value: [])
    lazy var feedElementItemViewSections = feedElementItemViewModels.map { [SectionModel(model: String.empty, items: $0)] }
    
    let feedItemSelected = PublishSubject<FeedElementItemViewModel>()
    
    init(userID: Int? = nil) {
        if let userID = userID {
            
            self.isMyProfile = .just(false)
            
            self.profile = GetProfile.default
                .use(input: .init(userID: userID))
                .map({ $0.profile })
            
            self.feedElements = GetFeedElements.default.use(input: .init(userID: userID))
                .map({ $0.realmFeedElements.filter({ $0.user?.id == userID }) })
            
        } else {
            
            self.isMyProfile = .just(true)
            
            self.profile = GetMyProfile.default
                .use()
                .map({ $0.profile })
            
            self.feedElements = GetMyFeedElements.default.use()
                .map({ $0.realmFeedElements })
        }
        
        super.init()
        self.refreshProfile(userID: userID)
    }
    
    override func subscribe() {
        
        typeContentViewIndex.map({ $0 == 0 ? .collection : .list })
            .bind(to: typeContentView)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(feedElementItemViewModels, typeContentView)
            .map({ items, typeContentView -> CGFloat in
                let count: Int = typeContentView == .collection ? max((items.count / 2), 1) : items.count
                let height: CGFloat = typeContentView == .collection ? 180 + 2 : 400
                
                return CGFloat(count) * height
            }).bind(to: contentHeight)
            .disposed(by: disposeBag)
                
        willAppear.skip(1).bind(onNext: {[weak self] in
            self?.refreshProfile()
        }).disposed(by: disposeBag)
        
        editProfile.bind(onNext: {
            Navigator.navigate(route: ProfileRoute.editProfile)
        }).disposed(by: disposeBag)
        
        willAppear.bind(onNext: { [weak self] in
            self?.refreshFeedElements(page: nil, userID: nil)
        }).disposed(by: disposeBag)
    
        feedElements.map({ $0.map(FeedElementItemViewModel.init) })
            .bind(to: feedElementItemViewModels).disposed(by: disposeBag)
                
        feedItemSelected.bind(onNext: {
            Navigator.navigate(route: StoryRoute.videoPlayerForFeed(realmFeedElement: $0.realmFeedElement))
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func refreshProfile(userID: Int? = nil) {
        if let userID = userID {
            self.invokeSingle(RefreshProfile.default, input: .init(userID: userID))
        } else {
            self.invokeSingle(RefreshMyProfile.default)
        }
    }
    
    private func refreshFeedElements(page: Int? = nil, userID: Int? = nil) {
        if let userID = userID {
//            self.invokeSingle(RefreshFeedElements.default, input: .init(page: page, userID: userID))
        } else {
            self.invokeSingle(RefreshMyFeedElements.default, input: .init(page: nil))
        }
    }
    
}


extension ProfileViewModel {
    
    enum TypeContentView {
        case collection
        case list
    }
    
}
