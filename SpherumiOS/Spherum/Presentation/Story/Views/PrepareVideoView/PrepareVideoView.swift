import UIKit
import SnapKit

class PrepareVideoView: XibView {
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    @IBOutlet weak var cancelButton: Button!

    override func loadUI() {
        
        super.loadUI()
        
        view.insertSubview(blurView, at: 0)
        
        configureLayout()
    }
    
    private func configureLayout() {
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

}
