//
//  AuthenticationModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 06/10/21.
//

import Foundation

public struct AuthenticationModel: Model {
    public let email: String
    public let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password        
    }
    
}
