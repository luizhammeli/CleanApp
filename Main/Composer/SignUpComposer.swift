//
//  SignUpComposer.swift
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

public final class SignUpComposer {
    static func composeController(with addAccount: AddAccount = UseCaseFactory.makeRemoteAddAccount()) -> SignUpViewController {
        guard let controller = SignUpViewController.instantiate() else { fatalError("SignUpViewController should be not nil") }
        let validationComposite = ValidationComposite(validations: makeValidation())
        let presenter = SignupPresenter(alertView: WeakVarProxy(controller),
                                        loadingView: WeakVarProxy(controller),
                                        addAccount: addAccount,
                                        validation: validationComposite)
        controller.signUp = presenter.signup
        return controller
    }
    
    static private func makeValidation() -> [Validation] {
        return [RequiredFieldsValidation(fieldName: "name", fieldLabel: "Nome"),
                RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
                EmailValidation(fieldName: "email", fieldLabel: "Email", validator: EmailValidatorAdapter()),
                RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
                RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
                RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
                CompareFieldValidation(fieldName: "password", fieldToCompare: "passwordConfirmation", fieldLabel: "password")
        ]
    }
}
