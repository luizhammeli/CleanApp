//
//  SignupPresenter.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import Foundation

public final class SignupPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signup(viewModel: SignupViewModel) {
        if let error = validate(viewModel: viewModel) {
            let alertViewModel = AlertViewModel(title: "Falha na validação", message: error)
            return alertView.showMessage(viewModel: alertViewModel)
        }
    }
    
    private func validate(viewModel: SignupViewModel) -> String? {
        guard let name = viewModel.name, !name.isEmpty else {
            return "O campo Nome é obrigatório"
        }
        guard let email = viewModel.email, !email.isEmpty else {
            return "O campo Email é obrigatório"
        }
        guard let password = viewModel.password, !password.isEmpty else {
            return "O campo Senha é obrigatório"
        }
        guard let passwordConfirmation = viewModel.passwordConfirmation, !passwordConfirmation.isEmpty else {
            return "O campo Confirmar Senha é obrigatório"
        }
        guard password == passwordConfirmation else {
            return "Os campos Senha e Confirmar Senha devem ser iguais"
        }
        guard emailValidator.isValid(email: email) else { return  "O Email inserido é inválido" }
        
        return nil
    }
}

public struct SignupViewModel {
    public let name: String?
    public let email: String?
    public let password: String?
    public let passwordConfirmation: String?
    
    public init(name: String?, email: String?, password: String?, passwordConfirmation: String?) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
