//
//  WelcomeRouter.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 12/10/21.
//

import UIKit

public final class WelcomeRouter {
    private let navigationController: CustomNavigationController
    private let loginFactory: () -> LoginViewController
    private let signupFactory: () -> SignUpViewController
    
    public init(navigationController: CustomNavigationController, loginFactory: @escaping () -> LoginViewController, signupFactory: @escaping () -> SignUpViewController) {
        self.navigationController = navigationController
        self.loginFactory = loginFactory
        self.signupFactory = signupFactory
    }
    
    public func goToLogin() {
        navigationController.pushViewController(loginFactory())        
    }
    
    public func goToSignup() {
        navigationController.pushViewController(signupFactory())
    }
}
