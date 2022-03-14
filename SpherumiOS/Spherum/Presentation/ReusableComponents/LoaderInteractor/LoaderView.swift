import UIKit
import SnapKit

class LoaderView: UIView {
    
    private let activityIndicatorBackgroundView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    func add(to parent: UIView) {
        parent.addSubview(self)
        
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func loadUI() {
        addViews()
        configureLayout()
        configureAppearence()
    }
    
    private func addViews() {
        addSubview(activityIndicatorBackgroundView)
        
        activityIndicatorBackgroundView.addSubview(activityIndicator)
    }
    
    private func configureLayout() {
        activityIndicatorBackgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureAppearence() {
        backgroundColor = .clear
        
        activityIndicatorBackgroundView.layer.cornerRadius = 8
        activityIndicatorBackgroundView.clipsToBounds = true
        activityIndicatorBackgroundView.backgroundColor = .appBlackColor.withAlphaComponent(0.8)
        
        activityIndicator.startAnimating()
        activityIndicator.color = .white
    }
    
}
