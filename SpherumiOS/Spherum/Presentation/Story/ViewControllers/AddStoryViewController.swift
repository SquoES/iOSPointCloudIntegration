import UIKit
import RxSwift
import RxMVVM
import SnapKit

class AddStoryViewController: ViewController<AddStoryViewModel> {
    
    @IBOutlet weak var recordTypeSelector: RecordTypeSelector!
    @IBOutlet weak var recordButton: RecordVideoButton!
    
    @IBOutlet weak var resultButtons: UIStackView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var reshotButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    let playerView = PlayerView()
    let cmSampleBufferView = CMSampleBufferView()
    
    let pointCloudMetalViewContentAdaptor = PointCloudMetalViewContentAdaptor()
    let pointCloudMetalView = PointCloudMetalView(frame: .zero)
    let pointCloudMetalViewGestureHandler = PointCloudMetalViewGestureHandler()
    
    let arPointCloudViewContentAdaptor = ARPointCloudViewContentAdaptor()
    let arPointCloudView = ARPointCloudView()
    let arPointCloudViewGestureHandler = ARPointCloudViewGestureHandler()
    
    let prepareVideoView = PrepareVideoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareVideoView.isHidden = true
        
        pointCloudMetalViewContentAdaptor.set(pointCloudMetalView: pointCloudMetalView)
        pointCloudMetalViewGestureHandler.set(view: pointCloudMetalView)
        
        arPointCloudViewContentAdaptor.set(arPointCloudView: arPointCloudView)
        arPointCloudViewGestureHandler.set(view: arPointCloudView)
        
        addViews()
        configureLayout()
        
//        gestureManager = GestureManager(with: self)
        
//        gestureManager.registerRotation { [weak self] rotation in
//            self?.demoView.rotate(usingRotation: rotation)
//        }
        
//        gestureManager.registerPan { [weak self] point in
//            self?.lastRotationXY = point
//        } changedHandler: { [weak self] point in
//            guard let self = self else {
//                return
//            }
//            self.arPointCloudView.yawAroundCenter(angle: (point.x - self.lastRotationXY.x) * 0.1)
//            self.arPointCloudView.pitchAroundCenter(angle: (point.y - self.lastRotationXY.y) * 0.1)
//            self.lastRotationXY = point
//        }

//        gestureManager.registerPinch { [weak self] in
//            self?.lastScale = 1
//        } changedHandler: { [weak self] scale in
//            guard let self = self else {
//                return
//            }
//            let diff = scale - self.lastScale
//            let factor: CGFloat = -1e3
//            
//            self.lastZoom = diff * factor
//        
//            self.arPointCloudView.moveTowardCenter(scale: self.lastZoom)
//            self.lastScale = scale
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pointCloudMetalView.resetView()
    }
    
    func addViews() {
        
        for view in [playerView, cmSampleBufferView,
                     pointCloudMetalView,
                     arPointCloudView] {
            self.view.insertSubview(view, at: .zero)
        }
        
        view.addSubview(prepareVideoView)
        
    }
    
    func configureLayout() {
        
        for view in [playerView, cmSampleBufferView,
                     pointCloudMetalView,
                     arPointCloudView] {
            view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        prepareVideoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    deinit {
        
    }
    
    override func bind(viewModel: ViewController<AddStoryViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: prepareVideoView.rx.isShown).disposed(by: disposeBag)
        
        prepareVideoView.rx.close.bind(to: viewModel.cancelPublish).disposed(by: disposeBag)
        
        rx.didAppear.bind(to: viewModel.didAppear).disposed(by: disposeBag)
        rx.didDisappear.bind(to: viewModel.didDisappear).disposed(by: disposeBag)
        
        publishButton.rx.tap.do(onNext: { [weak self] in
            self?.playerView.stopPlaying()
            self?.arPointCloudViewContentAdaptor.stopPlaying()
            self?.pointCloudMetalViewContentAdaptor.stopPlaying()
        }).bind(to: viewModel.publish).disposed(by: disposeBag)
        
        reshotButton.rx.tap
            .bind(to: viewModel.startRecording)
            .disposed(by: disposeBag)
        
        recordTypeSelector.selectedType.bind(to: viewModel.recordType).disposed(by: disposeBag)
        recordTypeSelector.selectedType.bind(onNext: { [weak self] in
            self?.update(for: $0)
        }).disposed(by: disposeBag)
        
        closeButton.rx.tap.bind(onNext: {
            Navigator.dismiss()
        }).disposed(by: disposeBag)
        
        recordTypeSelector.startRecord
            .do(onNext: { [weak self] in
                self?.recordButton.start()
            })
            .bind(to: viewModel.startRecording)
            .disposed(by: disposeBag)
        
        recordButton.rx.tap
            .bind(to: viewModel.stopRecording)
            .disposed(by: disposeBag)
                
        Observable.combineLatest(viewModel.state, viewModel.recorderOutput, viewModel.recordType)
            .observeOn(MainScheduler.asyncInstance)
            .bind(onNext: { [weak self] state, output, type in
                self?.updateUI(forState: state,
                               output: output,
                               type: type)
            }).disposed(by: disposeBag)
                
            viewModel.nextSample.bind(onNext: { [weak self] in
                self?.updateUI(forSample: $0)
            }).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    
    
    private func updateUI(forState state: AddStoryState, output: VideoContentRecorderOutput?, type: RecordType) {
        
        recordTypeSelector.isHidden = state != .selectingMode
        resultButtons.isHidden = state != .presenting
        recordButton.isHidden = state != .recording
        
        switch state {
        case .selectingMode:
            cmSampleBufferView.isHidden = type != .createModel
            playerView.isHidden = true
            
            pointCloudMetalView.isHidden = type != .faceID
            pointCloudMetalViewContentAdaptor.stopPlaying()
            
            arPointCloudView.isHidden = type != .lidar
            arPointCloudViewContentAdaptor.stopPlaying()
            
        case .recording:
            recordButton.start()
            cmSampleBufferView.isHidden = type != .createModel
            playerView.isHidden = true
            
            pointCloudMetalView.isHidden = type != .faceID
            pointCloudMetalViewContentAdaptor.stopPlaying()
            
            arPointCloudView.isHidden = type != .lidar
            arPointCloudViewContentAdaptor.stopPlaying()

        case .presenting:
            cmSampleBufferView.isHidden = true
            playerView.isHidden = type != .createModel
            
            pointCloudMetalView.isHidden = type != .faceID
            
            arPointCloudView.isHidden = type != .lidar
            
            play(usingOutput: output)
        }
        
    }
    
    private func updateUI(forSample sample: VideoContentProviderSessionOutputSample?) {
        switch sample {
        case let .createModelSample(cmSampleBuffer):
            cmSampleBufferView.update(withBuffer: cmSampleBuffer)
            
        case let .faceIDVideoSample(sampleBuffer, avDepthData):
            pointCloudMetalViewContentAdaptor.show(sampleBuffer: sampleBuffer,
                                                   depthData: avDepthData)
            
        case let .lidarSample(arData):
            arPointCloudViewContentAdaptor.show(arData: arData)
            
        default:
            break
        }
    }
    
    private func play(usingOutput output: VideoContentRecorderOutput?) {
        switch output {
        case let .createModel(videoURL):
            playerView.playVideo(url: videoURL)
            
        case let .lidar(videoURL, depthDataURL, confidenceDataURL):
            arPointCloudViewContentAdaptor.play(videoURL: videoURL,
                                                depthURL: depthDataURL,
                                                confidenceURL: confidenceDataURL)
            
        case let .faceID(videoURL, depthDataURL, depthMetaURL):
            pointCloudMetalViewContentAdaptor.play(videoURL: videoURL,
                                                   depthURL: depthDataURL,
                                                   depthMetaURL: depthMetaURL)
//            ActivityConstructor(using: [videoURL]).show()
            
        default:
            break
        }
    }
    
    private func stopPlaying() {
        playerView.stopPlaying()
    }
    
    private func update(for type: RecordType) {
        switch type {
        case .createModel:
            break
            
        case .faceID:
            break
            
        case .lidar:
            break
        }
    }
    
}
