//
//  SignupViewController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 12/09/21.
//

import UIKit
import Presentation

public final class SignUpViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    public var signUp: ((SignupViewModel) -> Void)?
    
    public override func viewDidLoad () {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        hideKeyboardOnTap()
        configureStackView()
        saveButton.layer.cornerRadius = 8
        navigationItem.title = "CleanApp"
    }
    
    @objc private func didTapSaveButton() {
        let signupViewModel = SignupViewModel(name: nameTextField.text,
                                              email: emailTextField.text,
                                              password: passwordTextField.text,
                                              passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(signupViewModel)
    }
    
    private func configureStackView() {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}

extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            self.saveButton.isEnabled = false
            self.loadingIndicator.startAnimating()
        } else {
            self.saveButton.isEnabled = true
            self.loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
