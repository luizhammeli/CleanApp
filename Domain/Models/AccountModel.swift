//
//  AccountModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 14/08/21.
//

import Foundation

public struct AccountModel: Model {
    public let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
