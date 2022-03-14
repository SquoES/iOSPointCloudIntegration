import Foundation
import RxMVVM
import RxSwift
import RxCocoa

class PasswordRecoveryViewModel: ViewModel {
    
    let email = BehaviorRelay<String?>(value: nil)
    let code = BehaviorRelay<String?>(value: nil)
    
    let requestIsSent = BehaviorRelay<Bool>(value: false)

    let sendEvent = PublishSubject<Void>()
    
    override func subscribe() {
        
        sendEvent
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(requestIsSent)
            .bind(onNext: {[weak self] isSent in
                isSent ? self?.sendUUIDCodeAtion() : self?.sendRecoveryRequestAction()
            }).disposed(by: disposeBag)
        
        
        super.subscribe()
    }
    
    private func sendRecoveryRequestAction() {
        guard let email = email.value else { return }
        
        self.invokeSingle(PasswordRecoveryRequest.default,
                          input: .init(email: email),
                          onCompleted: {[weak self] in
            self?.requestIsSent.accept(true)
        })
        
    }
    
    private func sendUUIDCodeAtion() {
        guard let code = self.code.value else { return }
        
        self.invokeSingle(VerifyPasswordRecovery.default,
                          input: .init(uuid: code),
                          onCompleted: {
            Navigator.navigate(route: MainRoute.tabBar, completion: nil)
        }
        )
    }
    
}
