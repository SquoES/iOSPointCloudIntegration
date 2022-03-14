import RxMVVM

enum StoryRoute: NavigationRouteType {
    
    case addStory
    case videoPlayerForFeed(realmFeedElement: RealmFeedElement)
    case videoPlayerForLive(realmLiveEvent: RealmLiveEvent)
    case player3D(videoPackage: VideoPackage)
    case arRecording
    
    var storyboardName: String {
        "Story"
    }
    
    var navigationAction: NavigationAction {
        switch self {
        case .addStory:
            return .create(navigationType: .modal) {
                let viewController = self.instantiateController(AddStoryViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: AddStoryViewModel())
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .overFullScreen
                return viewController
            }
            
        case let .videoPlayerForFeed(realmFeedElement):
            return .create(navigationType: .push) {
                return self.instantiateController(VideoPlayerViewController.self,
                                                  storyboardName: storyboardName,
                                                  viewModel: VideoPlayerViewModel(realmFeedElement: realmFeedElement))
            }
            
        case let .videoPlayerForLive(realmLiveEvent):
            return .create(navigationType: .push) {
                return self.instantiateController(VideoPlayerViewController.self,
                                                  storyboardName: storyboardName,
                                                  viewModel: VideoPlayerViewModel(realmLiveEvent: realmLiveEvent))
            }
            
        case let .player3D(videoPackage):
            return .create(navigationType: .push) {
                return self.instantiateController(Player3DViewController.self,
                                                  storyboardName: storyboardName,
                                                  viewModel: Player3DViewModel(videoPackage: videoPackage))
            }
            
        case .arRecording:
            return .create(navigationType: .modal) {
                let viewController = self.instantiateController(ARRecordingViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: ARRecordingViewModel())
                let navigationController = NavigationController(rootViewController: viewController)
                navigationController.modalTransitionStyle = .coverVertical
                navigationController.modalPresentationStyle = .overFullScreen
                return navigationController
            }
        }
    }
    
}
