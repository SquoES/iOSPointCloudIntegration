import Firebase
import FirebaseMessaging
import RxSwift
import RxMVVM

class FirebaseConfiguration: NSObject, Configuration, UNUserNotificationCenterDelegate {
    
    private let disposeBag = DisposeBag()
    
    private static let shared = FirebaseConfiguration()
    
    private func setupNotifications() {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound],
                                                                completionHandler: { _, _ in })
        
        Messaging.messaging().token { [weak self] fcmToken, error in
            if let fcmToken = fcmToken {
                print("NEW FCM TOKEN:", fcmToken)
                if let self = self {
                    RegisterCurrentDevice
                        .default
                        .use()
                        .subscribe()
                        .disposed(by: self.disposeBag)
                }
            } else {
                print("FCM TOKEN IS NIL")
            }
        }
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        print("willPresent notification:", userInfo)
        
        completionHandler([.sound, .banner, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print("didReceive response:", userInfo)
        
        Navigator.navigate(route: StoryRoute.arRecording)

        completionHandler()
    }
    
    static func setup() {
        FirebaseApp.configure()
        shared.setupNotifications()
        application.registerForRemoteNotifications()
    }
    
}

