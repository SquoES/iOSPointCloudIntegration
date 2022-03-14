import AVFoundation
import UIKit

extension CMSampleBuffer {
    
    func toUIImage() -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(self) else {
            return nil
        }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer).oriented(.right)
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
    
}
