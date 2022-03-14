import UIKit
import RxSwift
import RxMVVM
import SnapKit
import SwiftUI

class UnityPlayerViewController: ViewController<UnityPlayerViewModel> {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var progressView: UIStackView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    private var videoStarted = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func bind(viewModel: ViewController<UnityPlayerViewModel>.ViewModel) {
        
        closeButton.rx.tap.debug("PRESSED").bind(to: viewModel.close).disposed(by: disposeBag)
        
        viewModel.downloading.bind(to: progressView.rx.isShown).disposed(by: disposeBag)
        viewModel.downloading.bind(to: closeButton.rx.isShown).disposed(by: disposeBag)
        viewModel.progressString.bind(to: progressLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.startVideo.bind { [weak self] videoName in
            guard let self = self else {
                return
            }
            self.startVideoAction()
        }
        .disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    func startVideoAction() {
        guard !videoStarted else {
            return
        }
        guard let fileName = try? viewModel.startVideo.value() else {
            return
        }
        
        DispatchQueue.main.async {
            self.present(UnityCorePlayerViewController(fileName: fileName),
                         animated: true)
        }
    }
    
}
