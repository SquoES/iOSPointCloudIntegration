import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    func addSubviews() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureAppearence() {
        
    }
    
    private func initialize() {
        addSubviews()
        configureAppearence()
        configureLayout()
    }
    
}
