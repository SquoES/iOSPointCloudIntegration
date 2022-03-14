import UIKit

class StatefulTextField: UITextField {

    @IBInspectable var borderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    @IBInspectable var cornerRadius: CGFloat = 12.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable var defaultBorderColor: UIColor = .lightGrayColor { didSet { setNeedsDisplay() } }
    @IBInspectable var editingBorderColor: UIColor = .accentBlueColor { didSet { setNeedsDisplay() } }
    
    @IBInspectable var defaultBackgroundColor: UIColor = .lightGrayColor { didSet { setNeedsDisplay() } }
    @IBInspectable var editingBackgroundColor: UIColor = .white { didSet { setNeedsDisplay() } }
    
    @IBInspectable var horizontalTextInset: CGFloat = 16.0 { didSet { setNeedsLayout() } }
    
    @IBInspectable var placeholderColor: UIColor = .black30 {
        didSet{
            let attributes = NSAttributedString(string: placeholder ?? "",
                                                attributes: [
                                                    .font: self.font,
                                                    .foregroundColor: placeholderColor
                                                ])
            self.attributedPlaceholder = attributes
        }
    }
    
    @IBInspectable var isPassword: Bool = false {
        didSet {
            self.configPasswordStyle()
        }
    }
    
    lazy var doneButton: UIButton = {
        let doneButton = LinkButton()
        doneButton.setTitle("Done", for: .normal)
        return doneButton
    }()
    
    override var borderStyle: UITextField.BorderStyle {
        set { /* nothing :D */ }
        get { .none }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .gilroyFont(ofSize: 17, weight: .medium)
        bindActions()
        addToolbar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        font = .gilroyFont(ofSize: 17, weight: .medium)
        bindActions()
        addToolbar()
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth),
                                cornerRadius: cornerRadius)
        path.lineWidth = borderWidth
        
        currentBackgroundColor.setFill()
        currentBorderColor.setStroke()
        
        path.fill()
        path.stroke()
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return baseTextRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return baseTextRect(forBounds: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return baseTextRect(forBounds: bounds)
    }
    
}

private extension StatefulTextField {
    
    private func configPasswordStyle() {
        guard self .isPassword else { return }
        
        let securityButton = UIButton(type: .custom)
        
        securityButton.setTitle(nil, for: .normal)
        securityButton.setTitle(nil, for: .selected)
        
        securityButton.setImage(.show_password, for: .normal)
        securityButton.setImage(.hide_password, for: .selected)
        
        securityButton.addTarget(self, action: #selector(showHidePasswordButtonAction), for: .touchUpInside)
        
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        
        let spaceView = UIView(frame: .zero)
        spaceView.backgroundColor = .clear
        spaceView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        stack.addArrangedSubview(securityButton)
        stack.addArrangedSubview(spaceView)
        
        self.rightView = stack
        self.rightViewMode = .always
        
    }
    
    @objc private func showHidePasswordButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isSecureTextEntry = !sender.isSelected
    }
    
}

private extension StatefulTextField {
    
    func addToolbar() {
        let toolbar = UIToolbar()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                            target: nil,
                            action: nil),
            UIBarButtonItem(customView: doneButton)
        ], animated: false)
        toolbar.sizeToFit()
        
        inputAccessoryView = toolbar
    }
    
    func bindActions() {
        addTarget(self,
                  action: #selector(actionSended),
                  for: [.editingDidBegin, .editingDidEnd])
        
        doneButton.addTarget(self,
                             action: #selector(donePressed),
                             for: .touchUpInside)
    }
    
    @objc func actionSended() {
        setNeedsDisplay()
    }
    
    @objc func donePressed() {
        endEditing(true)
    }
    
    var currentBackgroundColor: UIColor {
        return isEditing ? editingBackgroundColor : defaultBackgroundColor
    }
    
    var currentBorderColor: UIColor {
        return isEditing ? editingBorderColor : defaultBorderColor
    }
    
    func baseTextRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalTextInset,
                              dy: .zero)
    }
    
}
