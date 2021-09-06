//
//  AccountModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 14/08/21.
//

import Foundation

public struct AccountModel: Model {
    public let accessToken: String
    public let name: String
    
    public init(accessToken: String, name: String) {
        self.accessToken = accessToken
        self.name = name
    }
}
