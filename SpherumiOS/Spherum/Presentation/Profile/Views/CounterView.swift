import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class CounterView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .gilroyFont(ofSize: 13, weight: .medium)
        label.textColor = .unselectedLightGrayColor
        label.textAlignment = .center
        
        addSubview(label)
        
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .gilroyFont(ofSize: 17, weight: .semibold)
        label.textColor = .black100
        label.textAlignment = .center
        
        addSubview(label)
        
        return label
    }()
    
    @IBInspectable var title: String? = nil {
        didSet {
            titleLabel.text = title
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var value: String? = nil {
        didSet {
            valueLabel.text = value
            self.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let halfHeight = frame.height / 2
        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: halfHeight)
        valueLabel.frame = CGRect(x: 0, y: halfHeight, width: frame.width, height: halfHeight)
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layoutSubviews()
    }
    
    
}

extension Reactive where Base: CounterView {
    
    var value: Binder<Int?>{
        return Binder<Int?>(base.self, binding: { view, value in
            guard let value = value else {
                return
            }

            view.value = IntFormatter.toAbbreviatedLargeNumberFormat(value)
        })
    }
    
}
