//
//  AddAccountModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation

public struct AddAccountModel: Model {
    public let name: String
    public let email: String
    public let passsword: String
    public let passswordConfirmation: String
    
    public init(name: String, email: String, passsword: String, passswordConfirmation: String) {
        self.name = name
        self.email = email
        self.passsword = passsword
        self.passswordConfirmation = passswordConfirmation
    }
}
