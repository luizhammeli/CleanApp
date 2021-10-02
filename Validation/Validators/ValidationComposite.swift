//
//  ValidationComposite.swift
//  Validation
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Presentation

public final class ValidationComposite: Validation {
    private let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validade(data: [String : Any]?) -> String? {
        for validation in validations {
            if let message = validation.validade(data: data) {
                return message
            }
        }
        return nil
    }
}
