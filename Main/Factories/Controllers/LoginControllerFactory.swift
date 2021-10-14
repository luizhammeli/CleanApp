//
//  LoginControllerFactory.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 11/10/21.
//

import Foundation
import Data
import UI
import Presentation
import Domain
import Validation

func makeLoginController() -> LoginViewController {
    return makeLoginController(with: makeRemoteAuthentication())
}

func makeLoginController(with authentication: Authentication = makeRemoteAuthentication()) -> LoginViewController {
    guard let controller = LoginViewController.instantiate() else { fatalError("LoginViewController should be not nil") }
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), authentication: authentication)
    controller.login = presenter.login
    return controller
}

func makeLoginValidations(emailValidator: EmailValidator = makeEmailValidatorAdapter()) -> [Validation] {
    return [RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", validator: emailValidator),
            RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
    ]
}
