//
//  Validation.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 28/09/21.
//

import Foundation

public protocol Validation {
    func validade(data: [String: Any]?) -> String?
}
