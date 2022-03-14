


import Foundation
import UIKit

@IBDesignable
class View: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 { didSet { self.setNeedsLayout(); self.layoutIfNeeded(); self.setNeedsDisplay() } }
    
    private var rectCorners: UIRectCorner = UIRectCorner([.allCorners]) { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable var topLeft: Bool = true { didSet { self.rectCorners.set(.topLeft, value: self.topLeft) } }
    @IBInspectable var topRight: Bool = true { didSet { self.rectCorners.set(.topRight, value: self.topRight) } }
    @IBInspectable var bottomLeft: Bool = true { didSet { self.rectCorners.set(.bottomLeft, value: self.bottomLeft) } }
    @IBInspectable var bottomRight: Bool = true { didSet { self.rectCorners.set(.bottomRight, value: self.bottomRight)} }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    
    
    @IBInspectable var fillColor: UIColor = .clear { didSet { self.layoutIfNeeded() } }
    @IBInspectable var borderColor: UIColor = .clear { didSet { self.layoutIfNeeded() } }
    
    
    @IBInspectable var shadowColor: UIColor! { didSet { reloadShadow() } }
    @IBInspectable var shadowOffset: CGSize = .zero { didSet { reloadShadow() } }
    @IBInspectable var shadowRadius: CGFloat = 0.0 { didSet { reloadShadow() } }
    
        
    private func reloadShadow() {
        self.layer.shadowColor = (self.shadowColor ?? .clear).cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = 1.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = fillColor
        self.layer.cornerRadius = self.cornerRadius
        self.layer.maskedCorners = .init(rawValue: rectCorners.rawValue)
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layoutSubviews()
    }
    
    
    
}

