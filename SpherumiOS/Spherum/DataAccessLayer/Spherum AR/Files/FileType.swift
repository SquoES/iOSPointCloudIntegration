//
//  FileType.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

enum FileType {
    
    case mov
    case depth
    case depthMeta
    
    var fileExtension: String {
        switch self {
        case .mov:
            return "mov"
            
        case .depth:
            return "depthdata"
            
        case .depthMeta:
            return "depth"
        }
    }
    
}
