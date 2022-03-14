import UIKit
import RxMVVM

class PasswordRecoveryViewController: ViewController<PasswordRecoveryViewModel> {
    
    @IBOutlet weak var emailTextField: StatefulTextField!
    @IBOutlet weak var codeTextField: StatefulTextField!
    @IBOutlet weak var acceptButton: GradientAccentButton!
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx.keyboardHeight(insetOnClose: 16)
            .bind(to: bottomScrollViewConstraint.rx.animateConstant())
            .disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<PasswordRecoveryViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        emailTextField.rx.text.bind(to: viewModel.email).disposed(by: disposeBag)
        codeTextField.rx.text.bind(to: viewModel.code).disposed(by: disposeBag)
        acceptButton.rx.tap.bind(to: viewModel.sendEvent).disposed(by: disposeBag)
        
        viewModel.requestIsSent.bind(onNext: {[weak self] isSent in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self?.emailTextField.isHidden = isSent
                self?.codeTextField.isHidden = !isSent
                
                self?.emailTextField.alpha = isSent ? 0 : 1
                self?.codeTextField.alpha = isSent ? 1 : 05
                
                self?.acceptButton.setTitle(isSent ? "Verify code" : "Send request", for: .normal)
            }, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.sendEvent.bind(onNext: {[weak self] in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        
        super.bind(viewModel: viewModel)
    }
    
    
}
