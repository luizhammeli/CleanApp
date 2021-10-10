//
//  AccountModelFactories.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 26/08/21.
//
import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    AccountModel(accessToken: "123")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "Test User", email: "teste@mail.com", password: "passwordTest", passwordConfirmation: "passwordTest")
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "teste@mail.com", password: "passwordTest")
}
