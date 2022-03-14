import RxSwift
import RxCocoa
import RxMVVM
import RxDataSources

class HomeViewModel: ViewModel {
    
    let selectedTab = BehaviorRelay<Int>(value: 0)
    
    private let feedItemViewModels = BehaviorRelay<[FeedElementItemViewModel]>(value: [])
    lazy var feedItemSections = feedItemViewModels.map({ [SectionModel(model: "", items: $0)] })
    
    private var loadStudioVideosTask: Task<Void, Error>?
    private let studioVideosLoaded = BehaviorRelay(value: false)
    private let videoGroups = BehaviorRelay<[BunnyCDNVideoGroup]>(value: [])
    lazy var videoGroupsItemViewModels = videoGroups.map { $0.map(BunnyCDNVideoItemViewModel.init) }
    
    lazy var itemSections = Observable.combineLatest(selectedTab, feedItemViewModels, videoGroupsItemViewModels, studioVideosLoaded)
        .map { selectedTab, feedItemViewModels, videoGroupsItemViewModels, studioVideosLoaded -> [SectionModel<String, HomeBlock>] in
            if selectedTab == 0 {
                return [SectionModel(model: "", items: feedItemViewModels.map { HomeBlock.feedItem($0) })]
            } else {
                if !studioVideosLoaded {
                    return [SectionModel(model: "", items: [HomeBlock.loading])]
                }
                return [SectionModel(model: "", items: videoGroupsItemViewModels.map { HomeBlock.videoItem($0) })]
            }
        }
    
    let itemSelected = PublishSubject<HomeBlock>()
    
    override func subscribe() {
        
        loadStudioVideos()
        
        invokeSingle(RefreshLiveEvents.default,
                     input: .init(page: nil))
        
        invokeSingle(RefreshFeedElements.default,
                     input: .init(page: nil, userID: nil))
        
        invokeObservable(GetFeedElements.default, input: .init(userID: nil)) { [weak self] in
            let viewModels = $0.realmFeedElements.map(FeedElementItemViewModel.init)
            self?.feedItemViewModels.accept(viewModels)
        }
        
        itemSelected.bind(onNext: {
            switch $0 {
            case let .videoItem(viewModel):
                Navigator.navigate(route: UnityPlayerRoute.player(videoGroup: viewModel.bunnyCDNVideoGroup))
                
            case let .feedItem(viewModel):
                Navigator.navigate(route: StoryRoute.videoPlayerForFeed(realmFeedElement: viewModel.realmFeedElement))
                
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func loadStudioVideos() {
        loadStudioVideosTask?.cancel()
        
        loadStudioVideosTask = Task { [weak self] in
            let videoGroups = await BunnyProvider.instance.prepareAndDownloadStudioVideos()
            
            if let videoGroups = videoGroups {
                self?.videoGroups.accept(videoGroups)
                self?.studioVideosLoaded.accept(true)
            }
        }
    }
}
