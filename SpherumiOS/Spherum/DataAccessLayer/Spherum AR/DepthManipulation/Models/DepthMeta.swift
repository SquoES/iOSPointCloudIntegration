//
//  DepthMeta.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

struct DepthMeta: Codable {
    
    let metaTags: [DepthMetaTag]
    
    let sampleSize: Int
    
    let dataDescription: DepthMetaDataDescription
    
}
