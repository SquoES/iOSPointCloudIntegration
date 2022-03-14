//
//  XibView.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 29.09.2021.
//

import Foundation
import UIKit

class XibView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        self.backgroundColor = .clear
        
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: type(of: self))
        let nibView = bundle.loadNibNamed(nibName, owner: self, options: nil)!.first! as! UIView
        
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        nibView.frame = self.bounds
        self.view = nibView
        self.addSubview(nibView)
        
        self.loadUI()
    }
    
    func loadUI() {
        
    }
    
}
