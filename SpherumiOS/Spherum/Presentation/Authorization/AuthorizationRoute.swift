import Foundation
import RxMVVM

enum AuthorizationRoute: NavigationRouteType {
    
    var storyboardName: String {
        return "Authorization"
    }
    
    case launchFuture
    case login
    case signIn(isRoot: Bool)
    case signUp(isRoot: Bool)
    case tellAboutMe
    case passwordRecovery
    
    case textDocument(title: String, link: URL)
    
    var navigationAction: NavigationAction {
        switch self {
            
        case .launchFuture:
            return .create(navigationType: .root) {
                let viewController = self.instantiateController(LaunchFutureViewController.controllerIdentifier,
                                                                storyboardName: storyboardName)
                return UINavigationController(rootViewController: viewController)
            }
        
        case .login:
            return .create(navigationType: .root) {
                self.instantiateController(LoginViewController.self,
                                           storyboardName: storyboardName,
                                           viewModel: LoginViewModel())
            }
        
        case let .signIn(isRoot):
            return .create(navigationType: isRoot ? .modal : .pushAndReplace) {
                let viewController = self.instantiateController(SignInViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: SignInViewModel())
                if isRoot {
                    return NavigationController(rootViewController: viewController)
                } else {
                    return viewController
                }
            }
        
        case let .signUp(isRoot):
            return .create(navigationType: isRoot ? .modal : .pushAndReplace) {
                let viewController = self.instantiateController(SignUpViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: SignUpViewModel())
                if isRoot {
                    return NavigationController(rootViewController: viewController)
                } else {
                    return viewController
                }
            }
        
        case .tellAboutMe:
            return .create(navigationType: .pushAndReplace) {
                let viewController = self.instantiateController(TellAboutMeViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: TellAboutMeViewModel())
                return viewController
            }
            
        case .passwordRecovery:
            return .create(navigationType: .push, {
                return self.instantiateController(PasswordRecoveryViewController.self, storyboardName: storyboardName, viewModel: PasswordRecoveryViewModel())
            })
            
        case let .textDocument(title, link):
            return .create(navigationType: .push) {
                let controller = self.instantiateController(TextDocumentViewController.controllerIdentifier,
                                                            storyboardName: storyboardName) as! TextDocumentViewController
                controller.setup(documentTitle: title, url: link)
                return controller
            }
        }
    }
    
}

extension Navigator {
    static func navigateAuthorization(authorizationRoute: AuthorizationRoute, complition: (() -> Void)?) {
        Navigator.navigate(route: authorizationRoute, completion: complition)
    }
}
