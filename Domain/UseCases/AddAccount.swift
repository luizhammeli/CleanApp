//
//  AddAccount.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 14/08/21.
//

import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result) -> Void)
}
