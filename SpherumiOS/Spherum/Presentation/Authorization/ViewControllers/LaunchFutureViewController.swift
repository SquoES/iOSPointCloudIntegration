import UIKit
import RxMVVM
import Lottie
import AVFoundation

class LaunchFutureViewController: UIViewController {
    
    @IBOutlet weak var launchButton: Button!
    
    private var animationView: AnimationView!
    @IBOutlet weak var avplayer: CustomAVPlayerView!
    
    @IBOutlet weak var legalInformationButton: UIButton!
    @IBOutlet weak var termsAndPoliciesButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
       
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "FinalVideo", withExtension: "mp4")!
        avplayer.play(with: url)
        
        configureLinkButton(legalInformationButton)
        configureLinkButton(termsAndPoliciesButton)
        
        launchButton.alpha = 0
        legalInformationButton.alpha = 0
        termsAndPoliciesButton.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            UIView.animate(withDuration: 1.5, animations: { [weak self] in
                self?.launchButton.alpha = 1.0
                self?.legalInformationButton.alpha = 1.0
                self?.termsAndPoliciesButton.alpha = 1.0
            })
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureLinkButton(_ button: UIButton) {
        let title = button.title(for: .normal) ?? ""
        let foregroundColor = button.titleColor(for: .normal) ?? .white.withAlphaComponent(0.7)
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .foregroundColor: foregroundColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func setUpAnimationView() {
        let animation = Animation.named("Final_1k")
        self.animationView = .init(animation: animation)
        self.animationView.frame = self.view.bounds

        self.animationView.contentMode = .scaleAspectFill
        self.animationView.loopMode = .loop

        self.animationView.animationSpeed = 1

        self.view.insertSubview(animationView, at: 0)

        animationView.play()
    }
        
    @IBAction func launchFutureAction(_ sender: Any) {
        Navigator.navigate(route: AuthorizationRoute.login)
    }
    
    @IBAction func openLegalInformation(_ sender: UIButton) {
        Navigator.navigate(route: AuthorizationRoute.textDocument(title: sender.title(for: .normal) ?? "",
                                                                  link: .legalInformation))
    }
    
    @IBAction func openTermsAndPolicies(_ sender: UIButton) {
        Navigator.navigate(route: AuthorizationRoute.textDocument(title: sender.title(for: .normal) ?? "",
                                                                  link: .termsAndPolicies))
    }
    
}
