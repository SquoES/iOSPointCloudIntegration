import Foundation
import SwiftUI

struct UnityVC: UIViewControllerRepresentable {

  func makeUIViewController(context: Context) -> UIViewController {
    
    let vc = UIViewController()
    UnityBridge.getInstance().SetViewController(controller: vc)
      
    UnityBridge.getInstance().onReady = {
        print("UnityVC: Unity is now ready!")

    }
      
    UnityBridge.getInstance().onShow = {
        print("UnityVC: Unity is now showing!")
    }
      
    UnityBridge.getInstance().onHide = {
        print("UnityVC: Unity hided!")
    }

    return vc
  }

  func updateUIViewController(_ viewController: UIViewController, context: Context) {
  }
}
