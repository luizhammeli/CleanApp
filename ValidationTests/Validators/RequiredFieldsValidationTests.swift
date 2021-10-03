//
//  RequiredFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Validation
import Presentation
import XCTest

final class RequiredFieldsValidationTests: XCTestCase {
    func test_should_return_error_if_field_is_not_provided() {
        let sut = RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email")
        let message = sut.validade(data: ["senha": "12345"])
        XCTAssertEqual(message, "O campo Email é obrigatório")
    }
    
    func test_should_return_error_if_field_is_empty() {
        let sut = RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email")
        let message = sut.validade(data: ["email": ""])
        XCTAssertEqual(message, "O campo Email é obrigatório")
    }
    
    func test_should_return_error_if_data_is_nil() {
        let sut = RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email")
        let message = sut.validade(data: nil)
        XCTAssertEqual(message, "O campo Email é obrigatório")
    }
    
    func test_should_return_success_if_data_is_correct() {
        let sut = RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email")
        XCTAssertNil(sut.validade(data: ["email": "test@gmail.com"]))
    }
}

extension RequiredFieldsValidationTests {
    func makeSut(fieldName: String, fieldLabel: String) -> RequiredFieldsValidation {
        let sut = RequiredFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut)
        return sut
    }
}
