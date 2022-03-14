//
//  AVConstants.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

typealias DepthMetaDictionaryRepresentaion = [AnyHashable: Any]

struct AVConstants {
    
    static let auxiliaryDataType = kCGImageAuxiliaryDataTypeDepth as NSString
    static let dataCompressionAlgorithm = NSData.CompressionAlgorithm.zlib

}
