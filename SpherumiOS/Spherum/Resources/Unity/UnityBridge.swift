//
//  Created by Simon Tysland on 19/08/2019.
//  Modified by Egor Skvortsov on 16/12/2021.
//

import Foundation
import UnityFramework

class API: NativeCallsProtocol {

    internal weak var bridge: UnityBridge!
    weak var unityCorePlayerViewController: UnityCorePlayerViewController!
    
    /**
        Function pointers to static functions declared in Unity
     */
    
    private var creatorMode: RunCreator!
    private var playerMode: RunPlayer!
    private var testMode: RunTest!
    
    /**
        Public API
     */
    
    public func setPlayerMode(shortPath: String) {
        self.playerMode(shortPath)
        print("SETTED")
    }
    public func setCreatorMode(shortPath: String) {
        self.creatorMode(shortPath)
    }
    public func setTestMode() {
        self.testMode()
    }
    
    /**
        Internal methods are called by Unity
     */
    
    internal func onUnityStateChange(_ state: String) {
        switch (state) {
        case "ready":
            self.bridge?.unityGotReady()
            self.unityCorePlayerViewController?.onReady()
        default:
            return
        }
    }
    
    
    internal func onSetRunCreator(_ delegate: RunCreator!) {
        self.creatorMode = delegate
    }
    internal func onSetRunPlayer(_ delegate: RunPlayer!) {
        self.playerMode = delegate
    }
    internal func onSetRunTest(_ delegate: RunTest!) {
        self.testMode = delegate
    }
    
}

class UnityBridge: UIResponder, UIApplicationDelegate, UnityFrameworkListener {
 
    private static var instance : UnityBridge?
    
    internal(set) public var isReady: Bool = false
    public var api: API
    private let ufw: UnityFramework
    
    public var viewController: UIViewController? {
        self.ufw.appController()?.rootViewController
    }
    public var view: UIView? {
        get { return self.ufw.appController()?.rootView }
    }
    
    public var uvc: UIViewController?
    
    //Callbacks
    public var onReady: () -> () = {}
    public var onShow: () -> () = {}
    public var onHide: () -> () = {}

    public static func getInstance() -> UnityBridge {
        if UnityBridge.instance == nil {
            UnityBridge.instance = UnityBridge()
        }
        return UnityBridge.instance!
    }
    
    private static func loadUnityFramework() -> UnityFramework? {
        let bundlePath: String = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
        let bundle = Bundle(path: bundlePath)
        if bundle?.isLoaded == false {
            bundle?.load()
        }
   
        let ufw = bundle?.principalClass?.getInstance()
        if ufw?.appController() == nil {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
            ufw!.setExecuteHeader(machineHeader)
        }
        return ufw
    }
    
    internal override init() {
        self.ufw = UnityBridge.loadUnityFramework()!
        self.ufw.setDataBundleId("com.unity3d.framework")
        self.api = API()
        super.init()
        self.api.bridge = self
        self.ufw.register(self)
        FrameworkLibAPI.registerAPIforNativeCalls(self.api)
        
        ufw.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: nil)
    }
    internal func SetViewController(controller: UIViewController){
        uvc = controller
    }
    
    public func show() {
        if self.isReady {
            self.ufw.showUnityWindow()
            onShow()
        }
        if let view = self.view {
            print("Bridge view set")
            uvc?.view?.addSubview(view)
        }
        onShow()
    }

    public func unload() {
        self.ufw.unloadApplication()
        onHide()
    }
    
    internal func unityGotReady() {
        self.isReady = true
        onReady()
    }
    
    internal func unityDidUnload(_ notification: Notification!) {
        ufw.unregisterFrameworkListener(self)
        UnityBridge.instance = nil
    }
}
