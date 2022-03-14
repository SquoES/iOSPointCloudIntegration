import UIKit
import UnityFramework

class UnityCorePlayerViewController: UIViewController, UnityFrameworkListener {
    
    private let fileName: String
    
    let closeButton = UIButton()

    private static let _unityAPI = API()
    
    private static let _unityFramework: UnityFramework? = {
        var unityBundlePath = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
        let unityBundle = Bundle(path: unityBundlePath)
        
        unityBundle?.load()
        
        let unityFramework = unityBundle?.principalClass?.getInstance()
        
        if let unityFramework = unityFramework {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
            unityFramework.setExecuteHeader(machineHeader)
        }
        
        return unityFramework
    }()
    
    var unityFramework: UnityFramework? {
        Self._unityFramework
    }
    
    var unityAPI: API {
        Self._unityAPI
    }
    
    var isUnitiInitialized: Bool {
        unityFramework?.appController() != nil
    }
    
    init(fileName: String) {
        self.fileName = fileName
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onReady() {
        unityAPI.setPlayerMode(shortPath: fileName)
    }
    
    func initializeUnity() {
        
        unityAPI.unityCorePlayerViewController = self
        
        prepareCalls()

        if isUnitiInitialized {
            unityAPI.setPlayerMode(shortPath: fileName)
            unityFramework?.pause(false)
            unityFramework?.showUnityWindow()
        } else {
        
            unityFramework?.setDataBundleId("com.unity3d.framework")
            
            
            unityFramework?.runEmbedded(withArgc: CommandLine.argc,
                                        argv: CommandLine.unsafeArgv,
                                        appLaunchOpts: nil)
            
        }
        
        prepareUnityView()
        
    }
    
    private func prepareCalls() {
        unityFramework?.register(self)
        FrameworkLibAPI.registerAPIforNativeCalls(unityAPI)
    }
    
    private func prepareUnityView() {
        guard let unityView = unityFramework?.appController()?.rootView else {
            return
        }
        
        closeButton.setImage(.closeNavigationIcon?.withRenderingMode(.alwaysTemplate),
                             for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self,
                              action: #selector(closeAction),
                              for: .touchUpInside)
        closeButton.setTitleColor(.white, for: .normal)
        
        unityView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
            $0.top.equalTo(inset > 20 ? inset : 0)
            $0.right.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    func deinitializeUnity() {
        closeButton.removeFromSuperview()
        unityFramework?.unregisterFrameworkListener(self)
        unityFramework?.pause(true)
        unityFramework?.appController()?.window?.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUnity()
    }
    
    @objc private func closeAction() {
        print("CLOSE")
        deinitializeUnity()
        let parentViewController = presentingViewController
        dismiss(animated: false)
        parentViewController?.dismiss(animated: false)
    }

}
