//
//  SignupViewModel.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Foundation
import Domain

public struct SignupViewModel: Model {
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
    
    public func toAddAccountModel() -> AddAccountModel? {
        guard let name = name,
              let email = email,
              let password = password,
              let passwordConfirmation = passwordConfirmation else { return nil }
        
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
}
