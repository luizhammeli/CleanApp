//
//  RequiredFieldsValidation.swift
//  Validation
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Foundation
import Presentation

public final class RequiredFieldsValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validade(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, !fieldValue.isEmpty else {
            return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }
    
    public static func == (lhs: RequiredFieldsValidation, rhs: RequiredFieldsValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
