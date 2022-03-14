import RxSwift
import RxMVVM
import ARKit
import ARCapture

class ARRecordingViewController: ViewController<ARRecordingViewModel> {
    
    @IBOutlet weak var placeModelButton: UIButton!
    @IBOutlet weak var recordingButton: RecordVideoButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    let sceneView = VirtualObjectARView()
    let coachingOverlay = ARCoachingOverlayView()
    let playerView = PlayerView()
    let prepareVideoView = PrepareVideoView()
    
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.example.apple-samplecode.arkitexample.serialSceneKitQueue")
    
    let virtualObjectsAnimator = VirtualObjectsAnimator()
    var virtualObjects: [VirtualObject] = VirtualObject.availableObjects
    
    var isVirtualObjectsPlaced: Bool = false
    
    var focusSquare = FocusSquare()
    
    var session: ARSession {
        return sceneView.session
    }
    
    lazy var arCapture = ARCapture(view: sceneView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(sceneView, at: 0)
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Set up coaching overlay.
//        setupCoachingOverlay()
        
        playerView.isHidden = true
        view.insertSubview(playerView, at: 1)
        
        prepareVideoView.isHidden = true
        view.insertSubview(prepareVideoView, at: 2)
        
        // Set up scene content.
        virtualObjects.forEach {
            sceneView.scene.rootNode.addChildNode($0)
        }
        
        virtualObjectsAnimator.set(virtualObjects: virtualObjects)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func bind(viewModel: ViewController<ARRecordingViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: prepareVideoView.rx.isShown).disposed(by: disposeBag)
        prepareVideoView.rx.close.bind(to: viewModel.cancelUpload).disposed(by: disposeBag)
        
        viewModel.isLoading.bind(onNext: { [weak self] in
            if $0 {
                self?.buttonsStack.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneView.frame = view.bounds
        playerView.frame = view.bounds
        prepareVideoView.frame = view.bounds
    }
    
    /// Creates a new AR configuration to run on the `session`.
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        if #available(iOS 12.0, *) {
            configuration.environmentTexturing = .automatic
        }
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Focus Square

    func updateFocusSquare(isObjectVisible: Bool) {
//        if isObjectVisible || !coachingOverlay.isActive {
//            focusSquare.hide()
//        } else {
//            focusSquare.unhide()
//        }
        
        // Perform ray casting only when ARKit tracking is in a good state.
        if let camera = session.currentFrame?.camera, case .normal = camera.trackingState,
            let query = sceneView.getRaycastQuery(),
            let result = sceneView.castRay(for: query).first {
            
            updateQueue.async {
                self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                self.focusSquare.state = .detecting(raycastResult: result, camera: camera)
            }
        } else {
            updateQueue.async {
                self.focusSquare.state = .initializing
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
        }
    }
    
    // MARK: - Object Manipulations
    
    func placeObject() {
        
        guard let query = sceneView.getRaycastQuery(for: .horizontal),
              let result = sceneView.castRay(for: query).first else {
            return
        }
        
        virtualObjects.forEach {
            $0.mostRecentInitialPlacementResult = result
            $0.raycastQuery = query
        }
        
        guard focusSquare.state != .initializing else {
            return
        }
        
        virtualObjects.forEach {
            let trackedRaycast = createTrackedRaycastAndSet3DPosition(of: $0,
                                                                      from: query,
                                                                      withInitialResult: $0.mostRecentInitialPlacementResult)
            $0.raycast = trackedRaycast
            $0.isHidden = false
        }
    }
    
    // - Tag: GetTrackedRaycast
    func createTrackedRaycastAndSet3DPosition(of virtualObject: VirtualObject, from query: ARRaycastQuery,
                                              withInitialResult initialResult: ARRaycastResult? = nil) -> ARTrackedRaycast? {
        if let initialResult = initialResult {
            self.setTransform(of: virtualObject, with: initialResult)
        }
        
        return session.trackedRaycast(query) { (results) in
            self.setVirtualObject3DPosition(results, with: virtualObject)
        }
    }
    
    // - Tag: ProcessRaycastResults
    private func setVirtualObject3DPosition(_ results: [ARRaycastResult], with virtualObject: VirtualObject) {
        
        guard let result = results.first else {
            return
//            fatalError("Unexpected case: the update handler is always supposed to return at least one result.")
        }
        
        self.setTransform(of: virtualObject, with: result)
        
        // If the virtual object is not yet in the scene, add it.
        if virtualObject.parent == nil {
            self.sceneView.scene.rootNode.addChildNode(virtualObject)
            virtualObject.shouldUpdateAnchor = true
        }
        
        if virtualObject.shouldUpdateAnchor {
            virtualObject.shouldUpdateAnchor = false
            self.updateQueue.async {
                self.sceneView.addOrUpdateAnchor(for: virtualObject)
            }
        }
    }
    
    func setTransform(of virtualObject: VirtualObject, with result: ARRaycastResult) {
        virtualObject.simdWorldTransform = result.worldTransform
    }
    
    private func playVideo() {
        guard let videoURL = arCapture?.videoUrl else {
            return
        }
        
        session.pause()
        
        buttonsStack.isHidden = false
        sceneView.isHidden = true
        playerView.isHidden = false
        playerView.playVideo(url: videoURL)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        guard !isVirtualObjectsPlaced else {
            return
        }
        
        placeModelButton.isHidden = true
        
        placeObject()
        focusSquare.isHidden = true
        isVirtualObjectsPlaced = true
        coachingOverlay.setActive(false, animated: false)
        recordingButton.isHidden = true
        recordButton.isHidden = false
        virtualObjectsAnimator.startAnimation()
    }
    
    @IBAction func startRecording(_ sender: Any) {
        coachingOverlay.setActive(false, animated: false)
        buttonsStack.isHidden = true
        recordingButton.isHidden = false
        recordButton.isHidden = true
        arCapture?.start()
        virtualObjectsAnimator.resetAnimation()
        recordingButton.start()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingButton.stop()
        recordingButton.isHidden = true
        arCapture?.stop({ [weak self] success in
            DispatchQueue.main.async {
                self?.playVideo()
            }
        })
    }
    
    @IBAction func reshotAction(_ sender: Any) {
        startRecording(sender)
    }
    
    @IBAction func publishAction(_ sender: Any) {
        guard let videoURL = arCapture?.videoUrl else {
            return
        }
        playerView.stopPlaying()
        viewModel.postVideo(url: videoURL)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        playerView.stopPlaying()
        Navigator.dismiss()
    }
    
    
}
