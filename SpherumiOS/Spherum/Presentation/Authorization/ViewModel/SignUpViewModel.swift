import RxSwift
import RxCocoa
import RxMVVM
import Accelerate

class SignUpViewModel: ViewModel {
    
    let name = BehaviorRelay<String?>(value: nil)
    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    let passwordRepeat = BehaviorRelay<String?>(value: nil)
        
    let signIn = PublishSubject<Void>()
    let close = PublishSubject<Void>()
    let signUp = PublishSubject<Void>()
    
    override func subscribe() {
        
        signIn.bind(onNext: {
            Navigator.navigate(route: AuthorizationRoute.signIn(isRoot: false))
        }).disposed(by: disposeBag)
        
        close.bind(onNext: {
            Navigator.dismiss()
        }).disposed(by: disposeBag)
        
        signUp.bind(onNext: {[weak self] in
            self?.signupAction()
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func signupAction() {
        guard let name = name.value,
              let email = email.value,
              let password = password.value,
              let passwordRepeat = passwordRepeat.value else { return }
        
        self.invokeSingle(SignUp.default,
                          input: .init(firstName: name,
                                       userName: name,
                                       email: email,
                                       password: password,
                                       rePassword: passwordRepeat),
                          onCompleted: {
                            Navigator.navigate(route: AuthorizationRoute.tellAboutMe)
                          })
        
    }
    
}
