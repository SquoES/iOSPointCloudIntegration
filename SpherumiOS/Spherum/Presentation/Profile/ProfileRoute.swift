import RxMVVM

enum ProfileRoute: NavigationRouteType {
    
    case myProfile
    case editProfile
    case profile(userID: Int)
    
    var storyboardName: String {
        "Profile"
    }
    
    var navigationAction: NavigationAction {
        switch self {
        case let .profile(userID):
            return .create(navigationType: .push) {
                return self.instantiateController(ProfileViewController.self,
                                                  storyboardName: storyboardName,
                                                  viewModel: ProfileViewModel(userID: userID))
            }
            
        case .editProfile:
            return .create(navigationType: .push, {
                return self.instantiateController(EditProfileViewController.self, storyboardName: storyboardName, viewModel: EditProfileViewModel())
            })
        
        case .myProfile:
            return .create(navigationType: .undefined, {
                let viewController = self.instantiateController(ProfileViewController.self,
                                                                storyboardName: storyboardName,
                                                                viewModel: ProfileViewModel(userID: nil))
                return NavigationController(rootViewController: viewController)
            })
        }
    }
    
}
