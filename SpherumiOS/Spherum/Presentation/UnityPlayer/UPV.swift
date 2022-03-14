import SwiftUI

struct UPV: SwiftUI.View {
    var body: some SwiftUI.View {
        SwiftUI.ZStack {
            Color.black
            
            UnityVC()
            
            SwiftUI.Button("PRESS") {
                print("Pressed Player")
                UnityBridge.getInstance().api.setPlayerMode(shortPath: "2021.12.8_Egor_Greeting")
                UnityBridge.getInstance().show()
            }.frame(width: 200, height: 50, alignment: .center)
        }
    }
}
