//
//  CompareFieldValidationsTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Presentation
import Validation
import XCTest

final class CompareFieldValidationTests: XCTestCase {
    func test_should_return_error_if_fields_comparation_fails() {
        let sut = makeSut(fieldName: "password", fieldToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let message = sut.validade(data: ["password":"1234", "passwordConfirmation":"12398"])
        XCTAssertEqual(message, "O campo Senha é inválido")
    }
    
    func test_should_return_error_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "password", fieldToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let message = sut.validade(data: nil)
        XCTAssertEqual(message, "O campo Senha é inválido")
    }
    
    func test_should_return_nil_if_fields_comparation_succeeds() {
        let sut = makeSut(fieldName: "password", fieldToCompare: "passwordConfirmation", fieldLabel: "password")
        XCTAssertNil(sut.validade(data: ["password":"1234", "passwordConfirmation":"1234"]))
    }
}

extension CompareFieldValidationTests {
    func makeSut(fieldName: String, fieldToCompare: String, fieldLabel: String) -> CompareFieldValidation {
        return CompareFieldValidation(fieldName: fieldName, fieldToCompare: fieldToCompare, fieldLabel: fieldLabel)
    }
}
