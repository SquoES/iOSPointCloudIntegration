//
//  DepthMetaTag.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

struct DepthMetaTag: Codable {
    
    let namespace: String
    let prefix: String
    let name: String
    let type: Int 
    
    var stringValue: String?
    var arrayOrderedValue: [Double]?
    
}
