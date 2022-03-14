import Foundation
import RxSwift
import RxCocoa
import RxMVVM
import AuthenticationServices

class LoginViewModel: ViewModel {
    
    let signInWithGoogle = PublishSubject<Void>()
    let signInWithFacebook = PublishSubject<Void>()
    let signInWithTwitter = PublishSubject<Void>()
    
    let signInWithEmail = PublishSubject<Void>()
    let signUp = PublishSubject<Void>()
    
    override func subscribe() {
        
        signInWithEmail.bind(onNext: {
            Navigator.navigate(route: AuthorizationRoute.signIn(isRoot: true))
        }).disposed(by: disposeBag)
        
        signUp.bind(onNext: {
            Navigator.navigate(route: AuthorizationRoute.signUp(isRoot: true))
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    func handleAppleID(code: String, firstName: String?, lastName: String?) {
     
        self.invokeSingle(SignIn.default, input: .apple(code: code, firstName: firstName, lastName: lastName)) {
            Navigator.navigate(route: MainRoute.tabBar)
        }
        
    }
    
}
