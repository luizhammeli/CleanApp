//
//  CompareFieldValidation.swift
//  Validation
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Foundation
import Presentation

public final class CompareFieldValidation: Validation {
    private let fieldName: String
    private let fieldToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldToCompare = fieldToCompare
        self.fieldLabel = fieldLabel
    }
    
    public func validade(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String,
              let fieldToCompare = data?[fieldToCompare] as? String,
              fieldValue == fieldToCompare else {
                  return "O campo \(fieldLabel) é inválido"
              }
        return nil
    }
}
