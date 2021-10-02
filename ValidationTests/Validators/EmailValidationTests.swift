//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Presentation
import Validation
import XCTest

final class EmailValidationTests: XCTestCase {
    func test_should_return_nil_if_email_is_valid() {
        let sut = makeSut()
        XCTAssertNil(sut.validade(data: ["email": "valid_email@gmail.com"]))
    }
    
    func test_should_return_error_if_email_is_invalid() {
        let validator = EmailValidatorSpy()
        let sut = makeSut(validator: validator)
        validator.setAsInvalid()
        let message = sut.validade(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(message, "O campo Email é inválido")
    }
    
    func test_should_return_error_with_correct_label() {
        let validator = EmailValidatorSpy()
        let sut = makeSut(fieldLabel: "Email2", validator: validator)
        validator.setAsInvalid()
        let message = sut.validade(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(message, "O campo Email2 é inválido")
    }
    
    func test_should_return_error_if_no_data_is_provided() {
        let validator = EmailValidatorSpy()
        let sut = makeSut(validator: validator)
        validator.setAsInvalid()
        let message = sut.validade(data: nil)
        XCTAssertEqual(message, "O campo Email é inválido")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String = "email", fieldLabel: String = "Email",validator: EmailValidator = EmailValidatorSpy()) -> EmailValidation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, validator: validator)
        checkMemoryLeak(for: sut)
        return sut
    }
}
