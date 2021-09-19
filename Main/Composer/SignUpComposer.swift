//
//  SignUpComposer.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import Foundation
import Domain
import Data
import UI

public final class SignUpComposer {
    static func composeController(with addAccount: AddAccount = UseCaseFactory.makeRemoteAddAccount()) -> SignUpViewController {
        ControllerFactory.makeSignup(addAccount: addAccount)
    }
}
