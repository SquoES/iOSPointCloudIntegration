//
//  Double+String.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 29.09.2021.
//

import Foundation

extension Double {
    var clean: String {
        String(format: "%.1f", self)
    }
}
