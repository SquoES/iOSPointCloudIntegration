//
//  DepthMetaTagConverter.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

class DepthMetaTagConverter {
    
    static func depthMetaTag(from cgImageMetadataTag: CGImageMetadataTag) -> DepthMetaTag? {
        guard let namespace = CGImageMetadataTagCopyNamespace(cgImageMetadataTag),
              let prefix = CGImageMetadataTagCopyPrefix(cgImageMetadataTag),
              let name = CGImageMetadataTagCopyName(cgImageMetadataTag) else {
            return nil
        }
        
        print("ORIGINAL TAG:", cgImageMetadataTag)
        let type = CGImageMetadataTagGetType(cgImageMetadataTag)
        
        var depthMetaTag = DepthMetaTag(namespace: namespace as String,
                                        prefix: prefix as String,
                                        name: name as String,
                                        type: Int(type.rawValue),
                                        stringValue: nil,
                                        arrayOrderedValue: nil)
        
        switch type {
        case .string:
            if let stringValue = CGImageMetadataTagCopyValue(cgImageMetadataTag) as? NSString {
                depthMetaTag.stringValue = stringValue as String
            }
        case .arrayOrdered:
            if let arrayValue = CGImageMetadataTagCopyValue(cgImageMetadataTag) as? NSArray {
                depthMetaTag.arrayOrderedValue = arrayValue.compactMap({ ($0 as? NSNumber)?.doubleValue })
            }
        default:
            return nil
        }
        
        return depthMetaTag
    }
    
    
    
    static func cgImageMetadataTag(from depthMetaTag: DepthMetaTag) -> CGImageMetadataTag? {
        guard let type = CGImageMetadataType(rawValue: Int32(depthMetaTag.type)) else {
            return nil
        }
        
        switch type {
        case .string:
            guard let stringValue = depthMetaTag.stringValue else {
                return nil
            }
            
            let string = stringValue as CFString
            
            return CGImageMetadataTagCreate(depthMetaTag.namespace as CFString,
                                            depthMetaTag.prefix as CFString,
                                            depthMetaTag.name as CFString,
                                            type,
                                            string)
            
        case .arrayOrdered:
            guard let arrayOrderedValue = depthMetaTag.arrayOrderedValue else {
                return nil
            }
            
            let array = NSArray(array: arrayOrderedValue) as CFArray
            
            return CGImageMetadataTagCreate(depthMetaTag.namespace as CFString,
                                            depthMetaTag.prefix as CFString,
                                            depthMetaTag.name as CFString,
                                            type,
                                            array)
            
        default:
            return nil
        }
    }
    
}
