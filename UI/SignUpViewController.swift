//
//  SignupViewController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 12/09/21.
//

import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    var signUp: ((SignupViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configure()
    }
    
    private func configure() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc private func didTapSaveButton() {
        signUp?(.init(name: nil, email: nil, password: nil, passwordConfirmation: nil))
    }
}

extension SignUpViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        
    }
}
