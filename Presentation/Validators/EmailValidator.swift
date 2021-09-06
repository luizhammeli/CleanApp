//
//  EmailValidator.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import Foundation

public protocol EmailValidator: AnyObject {
    func isValid(email: String) -> Bool
}
