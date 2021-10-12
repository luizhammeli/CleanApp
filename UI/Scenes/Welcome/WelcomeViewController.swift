//
//  WelcomeViewController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 12/10/21.
//

import UIKit

public final class WelcomeViewController: UIViewController, Storyboarded {
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var login: (() -> Void)?
    var signup: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        signupButton.layer.cornerRadius = 8
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.layer.cornerRadius = 8
    }
    
    @objc private func didTapSignupButton() {
        signup?()
    }
    
    @objc private func didTapLoginButton() {
        login?()
    }
}
