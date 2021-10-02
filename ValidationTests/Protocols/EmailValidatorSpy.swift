//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Validation

final class EmailValidatorSpy: EmailValidator {
    private var isValid = true
    var email: String?
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func setAsInvalid() {
        isValid = false
    }
}
