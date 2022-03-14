//
//  FileGroupNameBase.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

enum FileGroupNameBase {
    case nowDate
    case date(Date)
    case name(String)
    
    private static let dateFileFormat = "dd-MM-yyyy-HH-mm-ss"
    
    var filename: String {
        switch self {
        case .nowDate:
            return Date().string(withFormat: Self.dateFileFormat)
            
        case let .date(date):
            return date.string(withFormat: Self.dateFileFormat)
            
        case let .name(name):
            return name 
        }
    }
}
