import Foundation
import RxSwift

protocol AuthorizationRepositoryProtocol: BaseApiRepositoryProtocol {
    
    func login(username: String, password: String) -> Single<Void>
    func registration(firstName: String, userName: String, email: String, password: String, rePassword: String) -> Single<Void>
    func appleSignIn(code: String, firstName: String?, lastName: String?) -> Single<Void>
    
    func passwordRecovery(email: String) -> Single<Void>
    func verifyPasswordRecovery(uuid: String) -> Single<Void>
    
}
