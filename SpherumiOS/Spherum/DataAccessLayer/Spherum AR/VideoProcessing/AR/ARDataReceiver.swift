import Foundation
import ARKit

protocol ARDataReceiver: AnyObject {
    func onNewARData(arData: ARData)
}
