//
//  LoginViewModel.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 10/10/21.
//

import Foundation
import Domain

public struct LoginViewModel: Model {
    public let email: String?
    public let password: String?
    
    public init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
    
    public func toAuthenticationModel() -> AuthenticationModel? {
        guard let email = email, let password = password else { return nil }
        return AuthenticationModel(email: email, password: password)
    }
}
