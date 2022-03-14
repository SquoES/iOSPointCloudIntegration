//
//  OutputVideoType.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 20.06.2021.
//

import Foundation

enum OutputVideoType {
    
    case baseVideo
    case depthVideo
    
    var prefix: String {
        switch self {
        case .baseVideo: return "base"
        case .depthVideo: return "depth"
        }
    }
    
}
