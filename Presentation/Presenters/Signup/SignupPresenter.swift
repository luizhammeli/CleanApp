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
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView, loadingView: LoadingView, addAccount: AddAccount, validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signup(viewModel: SignupViewModel) {
        if let error = validation.validade(data: viewModel.toJson()) {
            let alertViewModel = AlertViewModel(title: "Falha na validação", message: error)
            alertView.showMessage(viewModel: alertViewModel)
        } else {
            guard let addAccountModel = viewModel.toAddAccountModel() else { return }
            loadingView.display(viewModel: .init(isLoading: true))
            
            addAccount.add(addAccountModel: addAccountModel, completion: { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: .init(isLoading: false))
                switch result {
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso",
                                                                         message: "Conta criada com sucesso."))
                case .failure(let error):
                    switch error {
                    case .emailInUse:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                             message: "Email já cadastrado"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                             message: "Ocorreu um erro ao realizar o cadastro, tente novamente."))
                    }
                }
            })
        }
    }
}
