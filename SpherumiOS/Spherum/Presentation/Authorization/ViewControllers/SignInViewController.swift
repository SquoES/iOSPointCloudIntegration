import Foundation
import RxSwift
import RxCocoa
import RxMVVM

class SignInViewController: ViewController<SignInViewModel> {
    
    @IBOutlet weak var signUpButton: LinkButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx.keyboardHeight(insetOnClose: 16)
            .bind(to: bottomScrollViewConstraint.rx.animateConstant())
            .disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<SignInViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        loginTextField.rx.text.bind(to: viewModel.login).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.password).disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap.bind(to: viewModel.resetPassword).disposed(by: disposeBag)
                        
        signUpButton.rx.tap.bind(to: viewModel.signUp).disposed(by: disposeBag)
        closeButton.rx.tap.bind(to: viewModel.close).disposed(by: disposeBag)
        signInButton.rx.tap.bind(to: viewModel.signIn).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
