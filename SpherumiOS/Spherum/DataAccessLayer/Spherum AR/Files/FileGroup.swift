//
//  FileGroup.swift
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 02.07.2021.
//

import Foundation

class FileGroup: NSObject {
    let movURL: URL
    let depthURL: URL
    let depthMetaURL: URL
    
    init(movURL: URL,
         depthURL: URL,
         depthMetaURL: URL) {
        self.movURL = movURL
        self.depthURL = depthURL
        self.depthMetaURL = depthMetaURL
    }
}
