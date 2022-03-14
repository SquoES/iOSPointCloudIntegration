import AVFoundation
import UIKit

class CMSampleBufferView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentMode = .scaleAspectFit
    }
    
    func update(withBuffer cmSampleBuffer: CMSampleBuffer) {
        DispatchQueue.main.async { [weak self] in
            self?.image = cmSampleBuffer.toUIImage()?.rotate(radians: -.pi/2)
        }
    }
    
}
