import UIKit
import RxMVVM
import RxBiBinding

class EditProfileViewController: ViewController<EditProfileViewModel> {
    

    @IBOutlet weak var saveTabBarButton: UIButton!
    @IBOutlet weak var saveButton: GradientAccentButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editPhotoButton: Button!
    @IBOutlet weak var userNameTextField: StatefulTextField!
    @IBOutlet weak var fullNameTextField: StatefulTextField!
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var mainBottomconstraint: NSLayoutConstraint!
    
    private lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.cornerRadius = 28
        self.navigationItem.backButtonTitle = " "
    }
    
    override func bind(viewModel: ViewController<EditProfileViewModel>.ViewModel) {
        
        (userNameTextField.rx.text <-> viewModel.userName).disposed(by: disposeBag)
        (fullNameTextField.rx.text <-> viewModel.fullName).disposed(by: disposeBag)
        (aboutTextView.rx.text <-> viewModel.about).disposed(by: disposeBag)
        viewModel.avatarURL.bind(to: avatarImageView.rx.imageURL).disposed(by: disposeBag)
        
        saveTabBarButton.rx.tap.bind(to: viewModel.saveProfile).disposed(by: disposeBag)
        saveButton.rx.tap.bind(to: viewModel.saveProfile).disposed(by: disposeBag)
        editPhotoButton.rx.tap.bind(to: viewModel.editPhotoPressed).disposed(by: disposeBag)
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
