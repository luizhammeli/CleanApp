//
//  LoginViewController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 10/10/21.
//

import UIKit

public final class LoginViewController: UIViewController, Storyboarded {
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    public override func viewDidLoad () {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = "4Devs"
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        submitButton.layer.cornerRadius = 8
        hideKeyboardOnTap()
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    @objc private func didTapSubmitButton() {}
}
