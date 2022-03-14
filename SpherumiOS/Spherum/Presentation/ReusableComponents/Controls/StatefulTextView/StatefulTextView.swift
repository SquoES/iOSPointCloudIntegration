//
//  StatefulTextView.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 06.10.2021.
//

import UIKit

class StatefulTextView: XibView {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var embeddedTextView: UITextView!
    
    @IBInspectable var text: String? = nil {
        didSet {
            self.embeddedTextView.text = text
        }
    }
    
}
