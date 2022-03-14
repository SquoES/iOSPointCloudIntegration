import Foundation
import Alamofire
import RxAlamofireWrapper

class AlamofireWrapperConfiguration: Configuration {
    
    static func setup() {
        #if DEBUG
        let sessionConfiguration = HTTPLogger.defaultSessionConfiguration()
        #else
        let sessionConfiguration = Alamofire.URLSessionConfiguration.default
        #endif
        sessionConfiguration.timeoutIntervalForRequest = 50_000
        sessionConfiguration.timeoutIntervalForResource = 50_000

        let tokenProvider = AccessTokenProvider(accessTokenType: .custom(headerName: "Authorization", prefix: "Bearer"))
        let interceptor = AuthorizationRequestInterceptor(tokenProvider: tokenProvider)
        
        let session = Session(configuration: sessionConfiguration,
                              interceptor: interceptor)
        
        AlamofireWrapper.shared.configure(session: session)
    }
    
}
