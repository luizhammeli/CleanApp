//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Presentation

func makeSignUpViewModel(name: String? = "Test User",
                         email: String? = "teste@mail.com",
                         password: String? = "passwordTest",
                         passwordConfirmation: String? =  "passwordTest") -> SignupViewModel {
    return SignupViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeLoginViewModel(email: String? = "teste@mail.com",
                        password: String? = "passwordTest") -> LoginViewModel {
    return LoginViewModel(email: email, password: password)
}

func makeSignupErrorAlertViewModel() -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: "Ocorreu um erro ao realizar o cadastro, tente novamente.")
}

func makeGenericLoginErrorAlertViewModel() -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: "Ocorreu um erro ao realizar o login, tente novamente.")
}


func makeSignupSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}

func makeLoadingViewModel(isLoading: Bool) -> LoadingViewModel {
    return .init(isLoading: isLoading)
}
