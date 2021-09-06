//
//  AccountModelFactories.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 26/08/21.
//
import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    AccountModel(accessToken: "123", name: "Test User")
}
