//
//  EmailValidation.swift
//  Validation
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Foundation
import Presentation

public final class EmailValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    private let validator: EmailValidator
    
    public init(fieldName: String, fieldLabel: String, validator: EmailValidator) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.validator = validator
    }
    
    public func validade(data: [String : Any]?) -> String? {
        guard let email = data?[fieldName] as? String, validator.isValid(email: email) else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
    
    
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
