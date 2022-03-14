import Foundation
import AVFoundation
import Accelerate

extension CVPixelBuffer {
    
    func normalizeDepth() {
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        
        CVPixelBufferLockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
        let floatBuffer = unsafeBitCast(CVPixelBufferGetBaseAddress(self), to: UnsafeMutablePointer<Float>.self)
        
        var minPixel: Float = 1.0
        var maxPixel: Float = 0.0
        
        for y in stride(from: 0, to: height, by: 1) {
            for x in stride(from: 0, to: width, by: 1) {
                let pixel = floatBuffer[y * width + x]
                minPixel = min(pixel, minPixel)
                maxPixel = max(pixel, maxPixel)
            }
        }
        
        let range = maxPixel - minPixel
        for y in stride(from: 0, to: height, by: 1) {
            for x in stride(from: 0, to: width, by: 1) {
                let pixel = floatBuffer[y * width + x]
                floatBuffer[y * width + x] = (pixel - minPixel) / range
            }
        }
        
        CVPixelBufferUnlockBaseAddress(self, CVPixelBufferLockFlags(rawValue: 0))
    }
    
    func texture(withFormat pixelFormat: MTLPixelFormat, planeIndex: Int, addToCache cache: CVMetalTextureCache) -> MTLTexture? {
        
        let width = CVPixelBufferGetWidthOfPlane(self, planeIndex)
        let height = CVPixelBufferGetHeightOfPlane(self, planeIndex)
        
        var cvtexture: CVMetalTexture?
        let status = CVMetalTextureCacheCreateTextureFromImage(nil, cache, self, nil, pixelFormat, width, height, planeIndex, &cvtexture)
        if status == kCVReturnSuccess {
            let texture = CVMetalTextureGetTexture(cvtexture!)
            
            return texture
        } else {
            return nil 
        }
        
    }
    
    public static func from(_ data: Data, width: Int, height: Int, pixelFormat: OSType, attributes: CFDictionary?) -> CVPixelBuffer {
        data.withUnsafeBytes { buffer in
            var pixelBuffer: CVPixelBuffer!

            let result = CVPixelBufferCreate(kCFAllocatorDefault, width, height, pixelFormat, attributes, &pixelBuffer)
            guard result == kCVReturnSuccess else { fatalError() }

            CVPixelBufferLockBaseAddress(pixelBuffer, [])
            defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, []) }

            var source = buffer.baseAddress!
            
            if CVPixelBufferIsPlanar(pixelBuffer) {

                for plane in 0 ..< CVPixelBufferGetPlaneCount(pixelBuffer) {
                    let dest = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, plane)
                    let height = CVPixelBufferGetHeightOfPlane(pixelBuffer, plane)
                    let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, plane)
                    let planeSize = height * bytesPerRow

                    memcpy(dest, source, planeSize)
                    source += planeSize
                }
                
            } else {
                let totalSize = CVPixelBufferGetHeight(pixelBuffer) * CVPixelBufferGetBytesPerRow(pixelBuffer)
                let destination = CVPixelBufferGetBaseAddress(pixelBuffer)
                
                memcpy(destination, source, totalSize)
            }

            return pixelBuffer
        }
    }
    
}
