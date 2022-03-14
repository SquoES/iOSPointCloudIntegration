import Foundation
import RxSwift
import RxAlamofireWrapper

class AuthorizationRepository: AuthorizationRepositoryProtocol {
    
    //MARK: - Sign in/up
    func login(username: String, password: String) -> Single<Void> {
        let json: [String: Any] = [
            JSONFieldConstants.username: username,
            JSONFieldConstants.password: password
        ]
        
        return self.request(ApiRouter.login, method: .post, json: json)
            .map(processLogin)
    }
    
    func registration(firstName: String, userName: String, email: String, password: String, rePassword: String) -> Single<Void> {
        let json: [String: Any] = [
            JSONFieldConstants.firstName: firstName,
            JSONFieldConstants.username: userName,
            JSONFieldConstants.email: email,
            JSONFieldConstants.password: password,
            JSONFieldConstants.rePassword: rePassword,
        ]
        
        return self.request(ApiRouter.users, method: .post, json: json)
            .map(processRegistration)
    }
    
    func appleSignIn(code: String, firstName: String?, lastName: String?) -> Single<Void> {
        var json: [String: Any] = [
            JSONFieldConstants.accessToken: code
        ]
        
        if let firstName = firstName {
            json[JSONFieldConstants.firstName] = firstName
        }
        if let lastName = lastName {
            json[JSONFieldConstants.lastName] = lastName
        }
        
        return self.request(ApiRouter.appleSignIn,
                            method: .post,
                            json: json).map(processLogin)
    }
    
    //MARK: - Password recovery
    func passwordRecovery(email: String) -> Single<Void> {
        return self.request(ApiRouter.passwordRecovery, method: .post, json: [JSONFieldConstants.email: email])
    }
    
    func verifyPasswordRecovery(uuid: String) -> Single<Void> {
        return self.request(ApiRouter.acceptPasswordRecovery(uuid: uuid), method: .post)
            .map(processLogin)
    }
    
}

fileprivate extension AuthorizationRepository {
    
    func processLogin(_ token: AuthorizationToken) {
        AccessTokenStorage.accessToken = token.token
    }
    
    func processRegistration(_ user: UserRetrieve) {
        //TODO: что-то нужно обработать?
    }
    
}
