//
//  AddAccount.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 14/08/21.
//

import Foundation

public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}
