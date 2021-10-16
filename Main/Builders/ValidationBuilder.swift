//
//  ValidationBuilder.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 16/10/21.
//

import Foundation
import Presentation
import Validation

public final class ValidationBuilder {
    private static var instance: ValidationBuilder?
    private var fieldName: String!
    private var fieldLabel: String!
    private var validations: [Validation] = []
    
    private init() {}
    
    public static func field(_ name: String) -> ValidationBuilder {
        instance = ValidationBuilder()
        instance?.fieldName = name
        instance?.fieldLabel = name
        return instance ?? ValidationBuilder()
    }
    
    public func label(_ name: String) -> ValidationBuilder {
        self.fieldLabel = name
        return self
    }
    
    public func required() -> ValidationBuilder {
        self.validations.append(contentsOf: [RequiredFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel)])
        return self
    }
    
    public func email(emailValidator: EmailValidator) -> ValidationBuilder {
        self.validations.append(contentsOf: [EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, validator: emailValidator)])
        return self
    }
    
    public func sameAs(_ name: String) -> ValidationBuilder {
        self.validations.append(contentsOf: [CompareFieldValidation(fieldName: fieldName, fieldToCompare: name, fieldLabel: fieldLabel)])
        return self
    }
    
    public func get() -> [Validation] {
        return validations
    }
}
