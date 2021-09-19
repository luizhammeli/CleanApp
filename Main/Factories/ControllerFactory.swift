//
//  SignupFactory.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import Foundation
import UI
import Presentation
import Validation
import Data
import Domain
import Infra

final class ControllerFactory {
    static func makeSignup() -> SignUpViewController {
        let emailValidator = EmailValidatorAdapter()
        let postClient = AlamofireAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let addAccount = RemoteAddAccount(url: url, postClient: postClient)
        guard let controller = SignUpViewController.instantiate() else { fatalError("SignUpViewController should be not nil") }
        let presenter = SignupPresenter(alertView: controller, loadingView: controller, emailValidator: emailValidator, addAccount: addAccount)
        controller.signUp = presenter.signup
        return controller
    }
}