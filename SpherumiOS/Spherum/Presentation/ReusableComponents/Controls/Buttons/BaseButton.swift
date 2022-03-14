import UIKit

class BaseButton: UIButton {
    
    override var isHighlighted: Bool { didSet { setNeedsDisplay() } }
    
    private let overlayColor: UIColor = .black.withAlphaComponent(0.4)
    
    override var buttonType: UIButton.ButtonType {
        get { .custom }
        set { /* nothing :D */ }
    }
    
    var useHighlightOverlay: Bool {
        false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialStyleSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialStyleSetup()
    }
    
    override func draw(_ rect: CGRect) {
        
        if useHighlightOverlay && isHighlighted {
            overlayColor.setFill()
            
            let overlayPath = UIBezierPath(rect: rect)
            overlayPath.fill()
        }
        
    }
    
    func initialStyleSetup() {
        
        
        
    }
    
}
