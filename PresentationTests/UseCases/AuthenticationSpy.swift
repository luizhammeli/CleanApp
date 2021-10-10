//
//  AuthenticateSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 10/10/21.
//

import Foundation
import Domain

final class AuthenticationSpy: Authentication {
    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?
    
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }
    
    func completeWithError(error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithSucess(accountModel: AccountModel = makeAccountModel()) {
        completion?(.success(accountModel))
    }
}
