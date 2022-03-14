import Foundation
import CoreVideo

enum CVPixelBufferPixelFormat {
    
    case format_420f
    case format_fdep
    case format_L008
    
    var attributes: CFDictionary {
        switch self {
        case .format_420f:
            return create420fAttributes()
            
        case .format_fdep:
            return createFdepAttributes()
            
        case .format_L008:
            return createL008Attributes()
        }
    }
    
}

fileprivate func create420fAttributes() -> CFDictionary {
    let pixelFormatDescription = [
        "BitsPerComponent": 8,
        "ComponentRange": "FullRange",
        "ContainsAlpha": false,
        "ContainsGrayscale": false,
        "ContainsRGB": false,
        "ContainsYCbCr": true,
        "IOSurfaceCoreAnimationCompatibility": 1,
        "IOSurfaceOpenGLESFBOCompatibility": 1,
        "IOSurfaceOpenGLESTextureCompatibility": 1,
        "OpenGLESCompatibility": 1,
        "PixelFormat": 875704422
    ] as CFDictionary
    
    return [
        "PixelFormatDescription": pixelFormatDescription
    ] as CFDictionary
}

fileprivate func createFdepAttributes() -> CFDictionary {
    let iosSurfaceProperties = [
        "IOSurfacePurgeWhenNotInUse": 1
    ]
    
    return [
        "Height": 192,
        "IOSurfaceProperties": iosSurfaceProperties,
        "PixelFormatType": 1717855600,
        "PlaneAlignment": 16,
        "Width": 256
    ] as CFDictionary
}

fileprivate func createL008Attributes() -> CFDictionary {
    let iosSurfaceProperties = [
        "IOSurfacePurgeWhenNotInUse": 1
    ]
    
    return [
        "Height": 192,
        "IOSurfaceProperties": iosSurfaceProperties,
        "PixelFormatType": 1278226488,
        "PlaneAlignment": 16,
        "Width": 256
    ] as CFDictionary
}
