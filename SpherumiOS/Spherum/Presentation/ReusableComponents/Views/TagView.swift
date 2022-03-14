import UIKit
import SnapKit

@IBDesignable
class TagView: BaseView {
    
    private let backgroundView = CustomizableView()
    private let label = UILabel()
    
    @IBInspectable var text: String! { didSet { label.text = text } }
    
    @IBInspectable var fillColor: UIColor = .appTagBackgroundViewColor { didSet { backgroundView.fillColor = fillColor } }
    
    override func addSubviews() {
        addSubviews(backgroundView,
                    label)
    }
    
    override func configureLayout() {
        snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configureAppearence() {
        backgroundColor = .clear
        
        backgroundView.fillColor = fillColor
        backgroundView.cornerRadius = min(frame.width, frame.height) / 2
        
        label.text = text
        
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .gilroyFont(ofSize: 13, weight: .semibold)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.cornerRadius = min(frame.width, frame.height) / 2
    }
    
}
