


import Foundation
import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    
    private var rectCorners: UIRectCorner = UIRectCorner([.allCorners]) { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable var topLeft: Bool = true { didSet { self.rectCorners.set(.topLeft, value: self.topLeft) } }
    @IBInspectable var topRight: Bool = true { didSet { self.rectCorners.set(.topRight, value: self.topRight) } }
    @IBInspectable var bottomLeft: Bool = true { didSet { self.rectCorners.set(.bottomLeft, value: self.bottomLeft) } }
    @IBInspectable var bottomRight: Bool = true { didSet { self.rectCorners.set(.bottomRight, value: self.bottomRight)} }
    
    @IBInspectable var borderWidth: CGFloat = 0 { didSet { self.setNeedsLayout(); self.layoutIfNeeded() } }
    
    @IBInspectable var enableColor: UIColor = .clear { didSet{ setNeedsLayout(); self.layoutIfNeeded(); setNeedsDisplay(); } }
    @IBInspectable var disableColor: UIColor? = nil { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable var selectedColor: UIColor? = nil { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable var highlightedColor: UIColor? = nil { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    @IBInspectable var borderColor: UIColor = .clear { didSet{ setNeedsLayout(); self.layoutIfNeeded() } }
    
    @IBInspectable var enableTextColor: UIColor = .black { didSet{ self.setTitleColor(enableTextColor, for: .normal); setNeedsDisplay() } }
    @IBInspectable var disableTextColor: UIColor? = nil { didSet{ self.setTitleColor(disableColor, for: .disabled); setNeedsDisplay() } }
    @IBInspectable var selectedTextColor: UIColor? = nil { didSet{ self.setTitleColor(selectedTextColor, for: .selected); setNeedsDisplay() } }
    
    @IBInspectable var shadowColor: UIColor! { didSet { reloadShadow() } }
    @IBInspectable var shadowOffset: CGSize = .zero { didSet { reloadShadow() } }
    @IBInspectable var shadowRadius: CGFloat = 0.0 { didSet { reloadShadow() } }
    
    
    @IBInspectable var selectedImage: UIImage? = nil {
        didSet {
            self.setImage(selectedImage, for: .selected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    private func loadUI() {
        backgroundColor = .clear
    }
    
    private func reloadShadow() {
        self.layer.shadowColor = (self.shadowColor ?? .clear).cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = 1.0
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        if isEnabled {
            
            if isHighlighted, let color = self.highlightedColor {
                color.setFill()
            }
            
            if isSelected, let color = self.selectedColor {
                color.setFill()
            } else {
                enableColor.setFill()
            }
            
        } else if let disableColor = self.disableColor {
            disableColor.setFill()
        }
        
        borderColor.setStroke()
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
        
        
        path.fill()
        path.stroke()
        
        
    }
    
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layoutSubviews()
    }
    
}
