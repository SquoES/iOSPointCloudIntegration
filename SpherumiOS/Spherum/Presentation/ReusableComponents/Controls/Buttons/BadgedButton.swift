import UIKit

@IBDesignable
class BadgedButton: UIButton {
    
    @IBInspectable var badge: Int = 0 {
        didSet {
            self.badgeView.badge = badge
        }
    }
        
    private lazy var badgeView: BadgeView = {
        let view = BadgeView()
        view.isHidden = badge == 0
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            view.heightAnchor.constraint(equalToConstant: 20),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: -7),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
        
        return view
    }()
    
    
}
