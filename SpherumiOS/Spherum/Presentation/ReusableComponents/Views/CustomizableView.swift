import Foundation
import UIKit

class CustomizableView: UIView {
    
    @IBInspectable var fillColor: UIColor = .white { didSet { setNeedsDisplay() } }
    
    @IBInspectable var cornerRadius: CGFloat = .zero { didSet { setNeedsDisplay() } }
    @IBInspectable var topLeftCornerRounded: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable var topRightCornerRounded: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable var bottomLeftCornerRounded: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable var bottomRightCornerRounded: Bool = false { didSet { setNeedsDisplay() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        let corners = roundedCorners
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius,
                                                    height: cornerRadius))
        
        fillColor.setFill()
        
        path.fill()
        
    }
    
}

private extension CustomizableView {
    
    var roundedCorners: UIRectCorner {
        var roundedCorners: UIRectCorner? = nil
        
        if topLeftCornerRounded {
            roundedCorners = [roundedCorners ?? .init(), .topLeft]
        }
        if topRightCornerRounded {
            roundedCorners = [roundedCorners ?? .init(), .topRight]
        }
        if bottomLeftCornerRounded {
            roundedCorners = [roundedCorners ?? .init(), .bottomLeft]
        }
        if bottomRightCornerRounded {
            roundedCorners = [roundedCorners ?? .init(), .bottomRight]
        }
        
        return roundedCorners ?? [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    
}
