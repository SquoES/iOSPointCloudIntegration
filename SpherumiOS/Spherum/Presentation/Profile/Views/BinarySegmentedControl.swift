import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class BinarySegmentedControl: UIControl {
    
    lazy var firstItemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        addSubview(view)
        return view
    }()
    
    lazy var secondItemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        addSubview(view)
        return view
    }()
    
    lazy var selectedUnderlineView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0,
                            y: frame.height - 3,
                            width: frame.width / 2,
                            height: 3)
        view.layer.cornerRadius = 1.5
        view.backgroundColor = .black100
        addSubview(view)
        return view
    }()
    
    @IBInspectable var firsItem: UIImage? = nil {
        didSet {
            guard let image = firsItem?.withRenderingMode(.alwaysTemplate) else { return }
            self.firstItemImageView.image = image
        }
    }
    
    @IBInspectable var secondItem: UIImage? = nil {
        didSet {
            guard let image = secondItem?.withRenderingMode(.alwaysTemplate) else { return }
            self.secondItemImageView.image = image
        }
    }
    
    @objc var selectedIndex: Int = 0 
    
    fileprivate var _selectedIndex: Int = 0 {
        didSet {
            changeIndexAction(newIndex: _selectedIndex)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.firstItemImageView.frame = CGRect(x: 0, y: 9, width: (frame.width / 2), height: frame.height - 20)
        self.secondItemImageView.frame = CGRect(x: (frame.width / 2), y: 9, width: (frame.width / 2), height: frame.height - 20)
        
        updateUnderline()
    }
    
    func updateUnderline() {
        let x = frame.width / 2 * CGFloat(_selectedIndex)
        selectedUnderlineView.frame = CGRect(x: x,
                                             y: frame.height - 3,
                                             width: frame.width / 2,
                                             height: 3)
    }
    
    private func setUp() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(tapGesture)
        
        _selectedIndex = 0
        selectedIndex = 0
        sendActions(for: .valueChanged)
    }
    
    private func changeIndexAction( newIndex: Int) {
        let isFirst = newIndex == 0
        
        firstItemImageView.tintColor = isFirst ? .black100 : .black30
        secondItemImageView.tintColor = isFirst ? .black30 : .black100
        
        updateUnderline()
    }
        
    //Gesture
    @objc private func tapGesture(gesture: UITapGestureRecognizer) {
        let x = gesture.location(in: self).x
        
        let index = x <= (frame.width / 2) ? 0 : 1
        _selectedIndex = index
        selectedIndex = index
        sendActions(for: .valueChanged)
    }
    
    @objc private func panGesture(gesture: UIPanGestureRecognizer) {
        let x = gesture.location(in: self).x
        
        if gesture.state != .cancelled {
            let index = x <= (frame.width / 2) ? 0 : 1
            _selectedIndex = index
            selectedIndex = index
            sendActions(for: .valueChanged)
        }
    }
    
}

extension Reactive where Base: BinarySegmentedControl {
    
    var selectedIndex: ControlProperty<Int> {
        
        let observe = controlEvent(.valueChanged)
            .map({ base._selectedIndex })
                
        let binder = Binder<Int>(base.self, binding: { view, index in
            view._selectedIndex = index
            view.selectedIndex = index
        })
        
        return ControlProperty<Int>(values: observe, valueSink: binder)
    }
    
}

