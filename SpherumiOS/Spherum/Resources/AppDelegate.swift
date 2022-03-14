import UIKit
import FirebaseMessaging
import RxMVVM

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        APPLY_CONFIGURATIONS(
            MapperConfiguration.self,
            NavigatorConfiguration.self,
            AlamofireWrapperConfiguration.self,
            FirebaseConfiguration.self
        )
        
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
//        Navigator.navigate(route: StoryRoute.arRecording)
        
        return true
    }

}

