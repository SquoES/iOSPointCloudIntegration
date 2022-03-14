import UIKit

class BadgeView: UIView {
    
    @IBInspectable var badge: Int = 0 { didSet{ badgeChanged(newValue: badge) } }
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .gilroyFont(ofSize: 13, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        
        return label
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.lightGradientColor.cgColor, UIColor.darkGradientColor.cgColor]
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.cornerRadius = self.frame.height / 2
        
        self.layer.insertSublayer(layer, at: 0)
        
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    
    private func badgeChanged(newValue: Int){
        self.isHidden = newValue <= 0
        self.badgeLabel.text = newValue.asString
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
