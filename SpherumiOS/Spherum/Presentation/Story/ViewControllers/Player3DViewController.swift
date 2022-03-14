import UIKit
import RxSwift
import RxMVVM

class Player3DViewController: ViewController<Player3DViewModel> {

    @IBOutlet weak var closeButton: UIButton!
    
    let pointCloudMetalViewContentAdaptor = PointCloudMetalViewContentAdaptor()
    let pointCloudMetalView = PointCloudMetalView(frame: .zero)
    let pointCloudMetalViewGestureHandler = PointCloudMetalViewGestureHandler()
    
    let arPointCloudViewContentAdaptor = ARPointCloudViewContentAdaptor()
    let arPointCloudView = ARPointCloudView()
    let arPointCloudViewGestureHandler = ARPointCloudViewGestureHandler()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pointCloudMetalViewGestureHandler.set(view: pointCloudMetalView)
        arPointCloudViewGestureHandler.set(view: arPointCloudView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pointCloudMetalView.frame = view.bounds
        arPointCloudView.frame = view.bounds
    }
    
    override func bind(viewModel: Player3DViewModel) {
        
        closeButton.rx.tap.bind(to: viewModel.close).disposed(by: disposeBag)
        
        viewModel.videoPackage.bind(onNext: { videoPackage in
            DispatchQueue.main.async { [weak self] in
                self?.setup(forVideoPackage: videoPackage)
            }
        }).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    private func setup(forVideoPackage videoPackage: VideoPackage) {
        
        switch videoPackage {
        case let .faceID(colorURL, depthURL, depthMetaURL):
            view.insertSubview(pointCloudMetalView, at: 0)
            pointCloudMetalView.frame = view.bounds
            pointCloudMetalViewContentAdaptor.set(pointCloudMetalView: pointCloudMetalView)
            pointCloudMetalViewContentAdaptor.play(videoURL: colorURL,
                                                   depthURL: depthURL,
                                                   depthMetaURL: depthMetaURL)
            
        case let .lidar(colorURL, depthURL, confidenceURL):
            view.insertSubview(arPointCloudView, at: 0)
            arPointCloudView.frame = view.bounds
            arPointCloudViewContentAdaptor.set(arPointCloudView: arPointCloudView)
            arPointCloudViewContentAdaptor.play(videoURL: colorURL,
                                                depthURL: depthURL,
                                                confidenceURL: confidenceURL)
            
        default:
            break
        }
        
    }

}
