import RxSwift
import RxMVVM
import AuthenticationServices

class LoginViewController: ViewController<LoginViewModel>, ASAuthorizationControllerDelegate {
    
    @IBOutlet weak var signInWithAppleButtonStack: UIStackView!
    
    @IBOutlet weak var signInWithEmailButton: UIButton!
    @IBOutlet weak var signUpNowButton: UIButton!
    
    let signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn,
                                                             style: .black)
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInWithAppleButton.cornerRadius = 12.0
        signInWithAppleButtonStack.addArrangedSubview(signInWithAppleButton)
    }

    override func bind(viewModel: ViewController<LoginViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        signInWithEmailButton.rx.tap.bind(to: viewModel.signInWithEmail).disposed(by: disposeBag)
        signUpNowButton.rx.tap.bind(to: viewModel.signUp).disposed(by: disposeBag)
        
        signInWithAppleButton.rx.controlEvent(.touchUpInside).bind { [weak self] in
            self?.signInWithAppleAction()
        }
        .disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    private func signInWithAppleAction() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let tokenData = credential.authorizationCode,
              let token = String(data: tokenData, encoding: .utf8) else {
                  return
              }
        
        let firstName = credential.fullName?.givenName
        let lastName = credential.fullName?.familyName
        
        #if DEBUG
        print("token:", token)
        #endif
        
        viewModel.handleAppleID(code: token,
                                firstName: firstName,
                                lastName: lastName)
    }
    
}
