//
//  SignupPresenter.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import Foundation
import Domain

public final class SignupPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    
    public func signup(viewModel: SignupViewModel) {
        if let error = validate(viewModel: viewModel) {
            let alertViewModel = AlertViewModel(title: "Falha na validação", message: error)
            alertView.showMessage(viewModel: alertViewModel)
        } else {
            guard let addAccountModel = makeAddAccountModel(with: viewModel) else { return }
            addAccount.add(addAccountModel: addAccountModel, completion: { result in
                switch result {
                case .failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Ocorreu um erro ao realizar o cadastro, tente novamente."))
                case .success:
                    break
                }
            })
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
    
    private func makeAddAccountModel(with signupViewModel: SignupViewModel) -> AddAccountModel? {
        guard let name = signupViewModel.name,
              let email = signupViewModel.email,
              let password = signupViewModel.password,
              let passwordConfirmation = signupViewModel.passwordConfirmation else { return nil }
        
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
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
