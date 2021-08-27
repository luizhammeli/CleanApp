//
//  AccountModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 14/08/21.
//

import Foundation

public struct AccountModel: Model {
    public let id: String
    public let name: String
    public let email: String
    public let passsword: String
    
    public init(id: String, name: String, email: String, passsword: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passsword = passsword
    }
}
