//
//  DepthMetaConverter.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation
import AVFoundation

class DepthMetaConverter {
    
    static func depthMeta(from dictionaryRepresentaion: DepthMetaDictionaryRepresentaion, depthSampleSize: Int) -> DepthMeta? {
        
        guard depthSampleSize > 0 else {
            return nil 
        }
        
        guard let cgImageMetadataValue = dictionaryRepresentaion[kCGImageAuxiliaryDataInfoMetadata] else {
            return nil
        }
        
        let cgImageMetadata = cgImageMetadataValue as! CGImageMetadata
        let cgImageMetadataTags = CGImageMetadataCopyTags(cgImageMetadata) as? [CGImageMetadataTag] ?? []
        let depthDataTags = cgImageMetadataTags.compactMap(DepthMetaTagConverter.depthMetaTag(from:))
        
        guard let infoDataDescriptionValue = dictionaryRepresentaion[kCGImageAuxiliaryDataInfoDataDescription] as? [String: Any] else {
            return nil
        }
        
        guard let width = (infoDataDescriptionValue["Width"] as? NSNumber)?.intValue,
              let height = (infoDataDescriptionValue["Height"] as? NSNumber)?.intValue,
              let bytesPerRow = (infoDataDescriptionValue["BytesPerRow"] as? NSNumber)?.intValue,
              let pixelFormat = (infoDataDescriptionValue["PixelFormat"] as? NSNumber)?.intValue else {
            return nil
        }

        let depthMetaDataDescription = DepthMetaDataDescription(width: width,
                                                                height: height,
                                                                bytesPerRow: bytesPerRow,
                                                                pixelFormat: pixelFormat)
        
        return DepthMeta(metaTags: depthDataTags,
                         sampleSize: depthSampleSize,
                         dataDescription: depthMetaDataDescription)
    }
    
    static func dictionaryRepresentation(from depthMeta: DepthMeta) -> DepthMetaDictionaryRepresentaion {
        var dictionaryRepresentation = DepthMetaDictionaryRepresentaion()
        
        // MARK: METADATA
        let cgImageMetadata = CGImageMetadataCreateMutable()

        for depthMetaTag in depthMeta.metaTags {
            guard let cgImageMetadataTag = DepthMetaTagConverter.cgImageMetadataTag(from: depthMetaTag) else {
                continue
            }

            guard CGImageMetadataRegisterNamespaceForPrefix(cgImageMetadata,
                                                            depthMetaTag.namespace as CFString,
                                                            depthMetaTag.prefix as CFString,
                                                            nil) else {
                print("CAN'T ADD NAMESPACE")
                continue
            }
            print("NAMESPACE ADDED")
            
            let tagPath = "\(depthMetaTag.prefix):\(depthMetaTag.name)"

            if CGImageMetadataSetTagWithPath(cgImageMetadata,
                                             nil,
                                             tagPath as CFString,
                                             cgImageMetadataTag) {
                print("TAG ADDED")
            } else {
                print("TAG NOT ADDED")
            }
        }
        
        dictionaryRepresentation[kCGImageAuxiliaryDataInfoMetadata] = cgImageMetadata
        
        // MARK: INFO DESCRIPTION
        
        let infoDataDescription = NSMutableDictionary()
        infoDataDescription.setObject(NSNumber(integerLiteral: depthMeta.dataDescription.width),
                                      forKey: NSString(string: "Width"))
        infoDataDescription.setObject(NSNumber(integerLiteral: depthMeta.dataDescription.height),
                                      forKey: NSString(string: "Height"))
        infoDataDescription.setObject(NSNumber(integerLiteral: depthMeta.dataDescription.bytesPerRow),
                                      forKey: NSString(string: "BytesPerRow"))
        infoDataDescription.setObject(NSNumber(integerLiteral: depthMeta.dataDescription.pixelFormat),
                                      forKey: NSString(string: "PixelFormat"))
        
        dictionaryRepresentation[kCGImageAuxiliaryDataInfoDataDescription] = infoDataDescription as CFDictionary
        
        return dictionaryRepresentation
        
    }
    
}
