import RxSwift
import RxCocoa
import RxMVVM
import RxDataSources

class FeedsViewModel: ViewModel {
    
    private let userID: Int?
    private let category: FeedCategory?
    
    lazy var title = Observable.just("#" + (category?.title ?? ""))
    lazy var followers = Observable.just((category?.followers_count?.toString() ?? "0") + " followers")
    lazy var isSubscribed = BehaviorRelay<Bool>(value: category?.is_subscribed ?? false)
    
    private let feedElementItemViewModels = BehaviorRelay<[FeedElementItemViewModel]>(value: [])
    lazy var feedElementItemViewSections = feedElementItemViewModels.map { [SectionModel(model: String.empty, items: $0)] }
    
    let switchSubscribe = PublishSubject<Void>()
    
    let feedItemSelected = PublishSubject<FeedElementItemViewModel>()
    
    init(userID: Int? = nil, category: FeedCategory? = nil){
        self.userID = userID
        self.category = category
    }
    
    override func subscribe() {
        
        self.invokeObservable(GetFilteredFeedElements.default,
                              input: .init(userID: userID,
                                           categoryID: category?.id),
                              onNext: {[weak self] output in
            let models = output.feedElement.map(FeedElementItemViewModel.init)
            self?.feedElementItemViewModels.accept(models)
        })
        
        switchSubscribe.bind(onNext: {[weak self] in
            self?.switchSubscribeAction()
        }).disposed(by: disposeBag)
        
        feedItemSelected.bind(onNext: {
            Navigator.navigate(route: StoryRoute.videoPlayerForFeed(realmFeedElement: $0.realmFeedElement))
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func switchSubscribeAction() {
        
        guard let categoryID = category?.id else { return }
        
        self.isSubscribed.toggle()
        
        self.invokeSingle(SwitchCategorySubscribe.default,
                          input: .init(categoryID: categoryID),
                          onError: {[weak self] _ in self?.isSubscribed.toggle()})
    }
}
