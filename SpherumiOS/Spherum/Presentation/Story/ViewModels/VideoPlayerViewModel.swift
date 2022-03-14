import RxSwift
import RxCocoa
import RxMVVM
import AVFoundation

class VideoPlayerViewModel: ViewModel {
    
    private let realmFeedElement: RealmFeedElement!
    private let realmLiveEvent: RealmLiveEvent!
    
    private(set) var videoPackage: VideoPackage?
    
    let likes = BehaviorRelay<String>(value: 0.toString())
    let views = BehaviorRelay<String>(value: 0.toString())
    
    let player = BehaviorRelay<AVPlayer?>(value: nil)
    
    let progress = BehaviorRelay<Float>(value: 0.0)
    
    let playing = BehaviorRelay<Bool>(value: false)
    let available3D = BehaviorRelay<Bool>(value: false)
    let isLive = BehaviorRelay<Bool>(value: false)
    
    let timeLeft = BehaviorRelay<String?>(value: "0:00")
    
    let fileProgress = BehaviorRelay<String?>(value: nil)
    
    let changeProgress = PublishSubject<Float>()
    let switchPlaying = PublishSubject<Void>()
    
    let open3D = PublishSubject<Void>()
    
    init(realmFeedElement: RealmFeedElement) {
        self.realmFeedElement = realmFeedElement
        self.realmLiveEvent = nil
        
        self.views.accept(realmFeedElement.views.toString())
        self.likes.accept(realmFeedElement.likedBy.count.toString())
        
        super.init()
        
        requestVideoPackageAction()
    }
    
    init(realmLiveEvent: RealmLiveEvent) {
        self.realmLiveEvent = realmLiveEvent
        self.realmFeedElement = nil
        
        self.isLive.accept(true)
        
        super.init()
        
        requestVideoPackageAction()
    }
    
    override func subscribe() {
        
        switchPlaying.bind(onNext: { [weak self] in
            self?.switchPlayingAction()
        }).disposed(by: disposeBag)
        
        changeProgress.bind(onNext: { [weak self] in
            self?.rewingVideoAction(to: $0)
        }).disposed(by: disposeBag)
        
        open3D.bind(onNext: { [weak self] in
            self?.open3DAction()
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func open3DAction() {
        guard let videoPackage = videoPackage else {
            return
        }

        pauseAction()
        
        Navigator.navigate(route: StoryRoute.player3D(videoPackage: videoPackage))
    }
    
    func pauseAction() {
        player.value!.pause()
        playing.accept(false)
    }
    
    private func requestVideoPackageAction() {
        if let realmMediaFile = realmFeedElement?.mediaFile {
            
            isLoading.onNext(true)
            
            invokeObservable(RequestVideoPackage.default, input: .init(realmMediaFile: realmMediaFile)) { [weak self] output in
                print("progress:", output.videoPackageProgress)
                
                DispatchQueue.main.async {
                    switch output.videoPackageProgress {
                    case let .downloading(progress):
                        let progressString = String(format: "Downloading: %.0f%%", progress * 100)
                        self?.fileProgress.accept(progressString)
                        
                    case let .unarchiving(progress):
                        let progressString = "Unarchining..." //String(format: "Unarchining: %.0f%%", progress * 100)
                        self?.fileProgress.accept(progressString)
                        
                    case let .completed(videoPackage):
                        self?.set(videoPackage: videoPackage)
                        self?.isLoading.onNext(false)
                    }
                }
            }
        }
        if let liveURL = realmLiveEvent?.url.url {
            set(videoPackage: .video2D(liveURL))
        }
    }
    
    private func rewingVideoAction(to progress: Float) {
        if let player = player.value, let duration = player.currentItem?.duration {
            let percentage = Int64(progress * 100)
            let newTime = CMTime(value: duration.value / 100 * percentage,
                                 timescale: duration.timescale)
            player.seek(to: newTime)
        }
    }
    
    private func switchPlayingAction() {
        
        if let player = player.value {
            if playing.value {
                player.pause()
                playing.accept(false)
                
            } else {
                if let duration = player.currentItem?.duration,
                   let progressTime = player.currentItem?.currentTime() {
                    
                    let durationSeconds = CMTimeGetSeconds(duration)
                    let seconds = CMTimeGetSeconds(progressTime)
                    let progress = Float(seconds/durationSeconds)
                    
                    if progress >= 1.0 {
                        player.seek(to: .zero)
                    }
                    
                    player.play()
                    playing.accept(true)
                }
            }
        }
        
    }
    
    private func set(videoPackage: VideoPackage?) {
        self.videoPackage = videoPackage
        
        guard let videoPackage = videoPackage else {
            return
        }
        
        switch videoPackage {
        case .createModel,  .video2D:
            available3D.accept(false)
        default:
            available3D.accept(true)
        }

        let player = AVPlayer(url: videoPackage.colorURL)
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: .main) { [weak self] progressTime in
            if let duration = player.currentItem?.duration {
                    
                let durationSeconds = CMTimeGetSeconds(duration)
                let seconds = CMTimeGetSeconds(progressTime)
                let progress = Float(seconds/durationSeconds)
                
                var timeLeftString = "0:00"
                
                if !durationSeconds.isNaN && !seconds.isNaN {
                    let secondsLeft = Int(durationSeconds - seconds)
                    let s = secondsLeft % 60
                    let m = secondsLeft / 60
                    timeLeftString = String(format: "%d:%02d", m, s)
                }
                    
                DispatchQueue.main.async {
                    self?.timeLeft.accept(timeLeftString)
                    self?.progress.accept(progress)
                    
                    if progress >= 1.0 {
                        self?.progress.accept(.zero)
                        self?.playing.accept(false)
                    }
                }
            }
        }
        
        self.player.accept(player)
        self.playing.accept(true)
        player.play()
    }
    
}
