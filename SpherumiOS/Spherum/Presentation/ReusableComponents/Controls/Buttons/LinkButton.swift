import UIKit

class LinkButton: BaseButton {
    
    override var buttonType: UIButton.ButtonType {
        get { .system }
        set { /* nothing :D */ }
    }
    
    override func initialStyleSetup() {
        
        setTitleColor(.accentBlueColor, for: .normal)
        titleLabel?.font = .gilroyFont(ofSize: 17, weight: .semibold)
        
    }
    
}
