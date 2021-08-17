//
//  AddAccountModel.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation

public struct AddAccountModel: Model {
    let name: String
    let email: String
    let passsword: String
    let passswordConfirmation: String
}
