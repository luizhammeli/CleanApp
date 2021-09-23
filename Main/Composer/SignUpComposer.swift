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
        let emailValidator = EmailValidatorAdapter()
        let presenter = SignupPresenter(alertView: WeakVarProxy(controller),
                                        loadingView: WeakVarProxy(controller),
                                        emailValidator: emailValidator,
                                        addAccount: addAccount)
        controller.signUp = presenter.signup
        return controller
    }
}
