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
    return [RequiredFieldsValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", validator: emailValidator),
            RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
            CompareFieldValidation(fieldName: "password", fieldToCompare: "passwordConfirmation", fieldLabel: "Senha")
    ]
}
