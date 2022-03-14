import RxSwift
import RxMVVM
import AVFoundation

class VideoPlayerViewController: ViewController<VideoPlayerViewModel> {
    
    @IBOutlet weak var videoInfoView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var open3DButton: Button!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let playerView = UIView()
    var playerLayer: AVPlayerLayer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(playerView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.asNavigationController()?.applyDarkStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.pauseAction()
    
        navigationController?.asNavigationController()?.applyLightStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerView.frame = view.bounds
        playerLayer?.frame = playerView.bounds
    }
    
    override func bind(viewModel: ViewController<VideoPlayerViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loadingView.rx.isShown).disposed(by: disposeBag)
        viewModel.fileProgress.bind(to: progressLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.playing.bind(to: playButton.rx.isSelected).disposed(by: disposeBag)
        
        viewModel.timeLeft.bind(to: timeLabel.rx.text).disposed(by: disposeBag)
        
        playButton.rx.tap.bind(to: viewModel.switchPlaying).disposed(by: disposeBag)
        
        viewModel.likes.bind(to: likesCountLabel.rx.text).disposed(by: disposeBag)
        viewModel.views.bind(to: viewsCountLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.player.bind(onNext: { [weak self] in
            guard let player = $0 else {
                return
            }
            self?.setupPlayerLayer(with: player)
        }).disposed(by: disposeBag)
        
        progressSlider.rx.value.bind(to: viewModel.changeProgress).disposed(by: disposeBag)
        viewModel.progress.bind(to: progressSlider.rx.value).disposed(by: disposeBag)
        
        viewModel.available3D.bind(to: open3DButton.rx.isShown).disposed(by: disposeBag)
        open3DButton.rx.tap.bind(to: viewModel.open3D).disposed(by: disposeBag)
        
        viewModel.isLive.bind(to: videoInfoView.rx.isHidden).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    private func setupPlayerLayer(with player: AVPlayer) {
        playerLayer?.player = nil
        playerLayer = nil
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspect
        if let isLidarPackage = viewModel.videoPackage?.isLidarPackage, isLidarPackage {
            playerLayer.setAffineTransform(CGAffineTransform(rotationAngle: .pi / 2))
        }
        playerView.layer.addSublayer(playerLayer)
    }
    
}
