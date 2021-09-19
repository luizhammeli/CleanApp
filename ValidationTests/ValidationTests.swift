//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import XCTest
import Presentation
//@testable import Validation

final class EmailValidatorAdapter: EmailValidator {
    func isValid(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = NSRange(location: 0, length: email.utf16.count)
        guard let regex = try?  NSRegularExpression(pattern: pattern) else { return false }
        let isValidEmail = regex.firstMatch(in: email, range: range) != nil
        return isValidEmail
    }
}

final class ValidationTests: XCTestCase {
    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "luiz"))
        XCTAssertFalse(sut.isValid(email: "luiz@"))
        XCTAssertFalse(sut.isValid(email: "luiz@gmail"))
        XCTAssertFalse(sut.isValid(email: "@gmail.com"))
        XCTAssertFalse(sut.isValid(email: ".com.br"))
    }
    
    func test_valid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.com.br"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.org"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.org.br"))
    }
}
