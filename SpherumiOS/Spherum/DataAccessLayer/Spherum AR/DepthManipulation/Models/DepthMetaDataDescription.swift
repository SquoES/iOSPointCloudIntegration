//
//  DepthMetaDataDescription.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

struct DepthMetaDataDescription: Codable {
    
    let width: Int
    let height: Int
    let bytesPerRow: Int
    let pixelFormat: Int
    
}
