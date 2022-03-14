import RxSwift
import RxCocoa
import RxMVVM
import RxDataSources

class DicsoveryViewModel: ViewModel {
    
    private let feedElementItemViewModels = BehaviorRelay<[FeedElementItemViewModel]>(value: [])
    lazy var feedElementItemViewSections = feedElementItemViewModels.map { [SectionModel(model: String.empty, items: $0)] }
    
    private let categoryItemViewModels = BehaviorRelay<[CategoryItemViewModel]>(value: [])
    lazy var categoryItemViewSections = categoryItemViewModels.map { [SectionModel(model: String.empty, items: $0)] }
    
    let categorySelected = PublishSubject<CategoryItemViewModel>()
    
    let feedItemSelected = PublishSubject<FeedElementItemViewModel>()
    
    override init() {
        super.init()
        
        self.invokeSingle(RefreshCategories.default)
        
        invokeObservable(GetFeedElements.default, input: .init(userID: nil)) { [weak self] in
            let viewModels = $0.realmFeedElements.map(FeedElementItemViewModel.init)
            self?.feedElementItemViewModels.accept(viewModels)
        }
        
        invokeObservable(GetCategories.default, onNext: {[weak self] output in
            let viewModels = output.categories.map(CategoryItemViewModel.init)
            self?.categoryItemViewModels.accept(viewModels)
        })
        
        categorySelected.bind(onNext: { viewModel in
            Navigator.navigate(route: DiscoveryRoute.feeds(userID: nil, category: viewModel.category), completion: nil)
        }).disposed(by: disposeBag)
        
        feedItemSelected.bind(onNext: {
            Navigator.navigate(route: StoryRoute.videoPlayerForFeed(realmFeedElement: $0.realmFeedElement))
        }).disposed(by: disposeBag)
        
    }
    
}
