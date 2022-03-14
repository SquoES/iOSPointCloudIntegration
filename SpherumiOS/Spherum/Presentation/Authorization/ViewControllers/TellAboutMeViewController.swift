//
//  TellAboutMeViewController.swift
//  Spherum
//
//  Created by Mikhail Eremeev on 06.10.2021.
//

import UIKit
import RxMVVM

class TellAboutMeViewController: ViewController<TellAboutMeViewModel> {
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var editPhotoView: EditPhotoView!
    @IBOutlet weak var yourNameTextField: StatefulTextField!
    @IBOutlet weak var aboutYourselfTextView: UITextView!
    @IBOutlet weak var maxCharactersInTextViewCountLabel: UILabel!
    @IBOutlet weak var saveButton: GradientAccentButton!
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    
    lazy var loaderInteractor = LoaderInteractor(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx.keyboardHeight(insetOnClose: 16)
            .bind(to: bottomScrollViewConstraint.rx.animateConstant())
            .disposed(by: disposeBag)
    }
    
    override func bind(viewModel: ViewController<TellAboutMeViewModel>.ViewModel) {
        
        viewModel.isLoading.bind(to: loaderInteractor.rx.isLoading).disposed(by: disposeBag)
        
        closeButton.rx.tap.bind(to: viewModel.close).disposed(by: disposeBag)
        
        viewModel.photo.bind(to: editPhotoView.rx.photo).disposed(by: disposeBag)
        
        editPhotoView.rx.editPhotoButtonTap.bind(to: viewModel.editPhoto).disposed(by: disposeBag)
        
        viewModel.aboutYourselfCharactersLimit.bind(to: maxCharactersInTextViewCountLabel.rx.text).disposed(by: disposeBag)
        
        yourNameTextField.rx.text.bind(to: viewModel.name).disposed(by: disposeBag)
        aboutYourselfTextView.rx.text.bind(to: viewModel.aboutYourself).disposed(by: disposeBag)
        
        saveButton.rx.tap.bind(to: viewModel.save).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
