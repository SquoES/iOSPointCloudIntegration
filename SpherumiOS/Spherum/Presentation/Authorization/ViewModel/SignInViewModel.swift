import Foundation
import RxSwift
import RxCocoa
import RxMVVM

class SignInViewModel: ViewModel {
    
    let login = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    lazy var signInButtonEnable = Observable.combineLatest(login, password).map({ login, password in
        return !(login ?? "").isEmpty && !(password ?? "").isEmpty
    })
    
    let resetPassword = PublishSubject<Void>()
    
    let signUp = PublishSubject<Void>()
    let close = PublishSubject<Void>()
    let signIn = PublishSubject<Void>()
    
    override func subscribe() {

        signUp.bind(onNext: {
            Navigator.navigate(route: AuthorizationRoute.signUp(isRoot: false))
        }).disposed(by: disposeBag)
        
        close.bind(onNext: {
            Navigator.dismiss()
        }).disposed(by: disposeBag)
        
        signIn.bind(onNext: {[weak self] in
            self?.signInAction()
        }).disposed(by: disposeBag)
        
        resetPassword.bind(onNext: {
            Navigator.navigate(route: AuthorizationRoute.passwordRecovery, completion: nil)
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func signInAction() {
        guard let login = login.value,
              let password = password.value else { return }
        
        self.invokeSingle(SignIn.default,
                          input: .credentials(username: login, password: password),
                          onCompleted: {
                            Navigator.navigate(route: MainRoute.tabBar)
                          })
        
    }
    
}
