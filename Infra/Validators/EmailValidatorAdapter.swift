//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import Foundation
import Validation

public final class EmailValidatorAdapter: EmailValidator {
    public init() {}
    
    public func isValid(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = NSRange(location: 0, length: email.utf16.count)
        guard let regex = try?  NSRegularExpression(pattern: pattern) else { return false }
        let isValidEmail = regex.firstMatch(in: email, range: range) != nil
        return isValidEmail
    }
}
