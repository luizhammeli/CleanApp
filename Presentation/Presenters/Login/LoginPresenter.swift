//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 10/10/21.
//

import Foundation
import Domain

public final class LoginPresenter {
    let validation: Validation
    let alertView: AlertView
    let loadingView: LoadingView
    let authentication: Authentication
    
    public init(validation: Validation, alertView: AlertView, loadingView: LoadingView, authentication: Authentication) {
        self.validation = validation
        self.alertView = alertView
        self.loadingView = loadingView
        self.authentication = authentication
    }
    
    public func login(viewModel: LoginViewModel) {
        if let error = validation.validade(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: .init(title: "Falha na validação", message: error))
        } else {
            guard let authenticationModel = viewModel.toAuthenticationModel() else {
                return alertView.showMessage(viewModel: .init(title: "Falha na validação", message: "Dados Inválidos"))
            }
            
            loadingView.display(viewModel: .init(isLoading: true))
            
            authentication.auth(authenticationModel: authenticationModel) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: .init(isLoading: false))
                
                switch result {
                case .success:
                    self.alertView.showMessage(viewModel: .init(title: "Login", message: "Login efetuado com sucesso."))
                case .failure(let error):
                    let errorMessage: String
                    switch error {
                    case .expiredSession:
                        errorMessage = "Email e/ou senha incorretos."
                    default:
                        errorMessage = "Ocorreu um erro ao realizar o login, tente novamente."
                    }
                    self.alertView.showMessage(viewModel: .init(title: "Erro", message: errorMessage))
                }
            }
        }
    }
}
