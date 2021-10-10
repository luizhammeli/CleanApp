//
//  Authentication.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 06/10/21.
//

import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Result) -> Void)
}
