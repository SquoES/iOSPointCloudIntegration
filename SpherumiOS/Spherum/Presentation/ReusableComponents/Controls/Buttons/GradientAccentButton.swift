import UIKit

class GradientAccentButton: BaseButton {
    
    private let gradientBackgroundImage = UIImage.gradientPrimaryButtonBackground
    
    private let cornerRadius: CGFloat = 12.0
    
    override var useHighlightOverlay: Bool {
        true
    }
        
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(roundedRect: rect,
                                cornerRadius: cornerRadius)
        path.addClip()
        
        gradientBackgroundImage?.draw(in: rect)
        
        super.draw(rect)
        
        context?.resetClip()
        
    }
    
    override func initialStyleSetup() {
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .gilroyFont(ofSize: 20, weight: .semibold)
        
    }
    
}
