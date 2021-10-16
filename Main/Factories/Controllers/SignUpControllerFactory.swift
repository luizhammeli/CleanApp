//
//  SignUpComposer.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import UI
import Presentation
import Validation
import Data
import Domain

func makeSignupController() -> SignUpViewController {
    return makeSignupController(with: makeRemoteAddAccount())
}

func makeSignupController(with addAccount: AddAccount = makeRemoteAddAccount()) -> SignUpViewController {
    guard let controller = SignUpViewController.instantiate() else { fatalError("SignUpViewController should be not nil") }
    let validationComposite = ValidationComposite(validations: makeValidations())
    let presenter = SignupPresenter(alertView: WeakVarProxy(controller),
                                    loadingView: WeakVarProxy(controller),
                                    addAccount: addAccount,
                                    validation: validationComposite)
    controller.signUp = presenter.signup
    return controller
}

func makeValidations(emailValidator: EmailValidator = makeEmailValidatorAdapter()) -> [Validation] {
    return ValidationBuilder.field("name").label("Nome").required().get() +
    ValidationBuilder.field("email").label("Email").required().email(emailValidator: emailValidator).get() +
    ValidationBuilder.field("password").label("Senha").required().get() +
    ValidationBuilder.field("passwordConfirmation").label("Confirmar Senha").required().sameAs("password").get()
}
