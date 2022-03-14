import Foundation
import AVFoundation

extension Data {
    public static func from(pixelBuffer: CVPixelBuffer) -> Self {
        CVPixelBufferLockBaseAddress(pixelBuffer, [.readOnly])
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, [.readOnly]) }

        if CVPixelBufferIsPlanar(pixelBuffer) {
        
            var totalSize = 0
            for plane in 0 ..< CVPixelBufferGetPlaneCount(pixelBuffer) {
                let height = CVPixelBufferGetHeightOfPlane(pixelBuffer, plane)
                let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, plane)
                let planeSize = height * bytesPerRow
                totalSize += planeSize
            }

            guard let rawFrame = malloc(totalSize) else { fatalError() }
            var dest = rawFrame
            
            for plane in 0 ..< CVPixelBufferGetPlaneCount(pixelBuffer) {
                let source = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, plane)
                let height = CVPixelBufferGetHeightOfPlane(pixelBuffer, plane)
                let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, plane)
                let planeSize = height * bytesPerRow

                memcpy(dest, source, planeSize)
                dest += planeSize
            }

            return Data(bytesNoCopy: rawFrame, count: totalSize, deallocator: .free)
            
        } else {
            
            let totalSize = CVPixelBufferGetHeight(pixelBuffer) * CVPixelBufferGetBytesPerRow(pixelBuffer)
            
            guard let newFrame = malloc(totalSize) else { fatalError() }
            
            let source = CVPixelBufferGetBaseAddress(pixelBuffer)
            
            memcpy(newFrame, source, totalSize)
            
            return Data(bytesNoCopy: newFrame, count: totalSize, deallocator: .free)
            
        }
        
    }
}
