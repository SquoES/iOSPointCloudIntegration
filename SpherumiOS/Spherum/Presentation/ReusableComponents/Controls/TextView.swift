import UIKit
import RxSwift

class TextView: UITextView {
    
    private var placeholderTextView: UITextView = UITextView()
    @IBInspectable var placeholder: String? {
        didSet {
            placeholderTextView.isUserInteractionEnabled = false
            placeholderTextView.text = placeholder
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = .black30 {
        didSet {
            placeholderTextView.textColor = placeholderColor
        }
    }
        
    private let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem.init(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(doneAction))
        
        return button
    }()
        
    
    override var text: String! {
        didSet {
            placeholderTextView.isHidden = !text.isEmpty
        }
    }
    
    var isEditing = false {
        didSet {
            updateUI()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        self.layer.cornerRadius = 12
        self.backgroundColor = .black5
        self.layer.borderColor = UIColor.accentBlueColor.cgColor
        
        self.tintColor = .primary500
        
        commonInit()
        addDoneButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderTextView.frame = bounds
    }
    
    func addPlaceholderTextView() {
        applyCommonTextViewAttributes(to: placeholderTextView)
        configurePlaceholderTextView()
        insertSubview(placeholderTextView, at: 0)
    }
        
    private func configurePlaceholderTextView() {
        placeholderTextView.backgroundColor = UIColor.clear
        placeholderTextView.text = placeholder
        placeholderTextView.font = font
        placeholderTextView.textColor = placeholderColor
        placeholderTextView.frame = bounds
        placeholderTextView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func applyCommonTextViewAttributes(to textView: UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    private func commonInit() {
        delegate = self
        applyCommonTextViewAttributes(to: self)
        addPlaceholderTextView()
    }
        
    private func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                            target: nil,
                            action: nil),
            doneButton
        ], animated: false)
        
        toolbar.sizeToFit()
        
        inputAccessoryView = toolbar
    }
    
    @objc private func doneAction() {
        endEditing(true)
    }
    
    private func updateUI() {
        self.backgroundColor = isEditing ? .white : .black5
        self.layer.borderWidth = isEditing ? 1.0 : 0.0
    }
    
}

extension TextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        isEditing = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        isEditing = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderTextView.isHidden = !text.isEmpty
        textView.text = String(textView.text?.prefix(200) ?? "")
    }
    
}
