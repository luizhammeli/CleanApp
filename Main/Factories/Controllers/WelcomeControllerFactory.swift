//
//  WelcomeControllerFactory.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 13/10/21.
//

import UIKit
import UI

func makeWelcomeController(navController: CustomNavigationController) -> WelcomeViewController {
    let welcomeRounter = WelcomeRouter(navigationController: navController, loginFactory: makeLoginController, signupFactory: makeSignupController)
    let welcomeController = WelcomeViewController.instantiate()!
    welcomeController.login = welcomeRounter.goToLogin
    welcomeController.signup = welcomeRounter.goToSignup
    return welcomeController
}
