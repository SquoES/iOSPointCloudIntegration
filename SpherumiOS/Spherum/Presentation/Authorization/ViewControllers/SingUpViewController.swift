import UIKit
import RxSwift
import RxMVVM

class SignUpViewController: ViewController<SignUpViewModel> {
    
    @IBOutlet weak var signInButton: LinkButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var nameTextField: StatefulTextField!
    @IBOutlet weak var emailTextField: StatefulTextField!
    @IBOutlet weak var passwordTextField: StatefulTextField!
    @IBOutlet weak var repeatPasswordTextField: StatefulTextField!
    
    @IBOutlet weak var signUpButton: GradientAccentButton!
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx.keyboardHeight(insetOnClose: 16)
            .bind(to: bottomScrollViewConstraint.rx.animateConstant())
            .disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<SignUpViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        nameTextField.rx.text.bind(to: viewModel.name).disposed(by: disposeBag)
        emailTextField.rx.text.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.password).disposed(by: disposeBag)
        repeatPasswordTextField.rx.text.bind(to: viewModel.passwordRepeat).disposed(by: disposeBag)
        
        signInButton.rx.tap.bind(to: viewModel.signIn).disposed(by: disposeBag)
        closeButton.rx.tap.bind(to: viewModel.close).disposed(by: disposeBag)
        signUpButton.rx.tap.bind(to: viewModel.signUp).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
