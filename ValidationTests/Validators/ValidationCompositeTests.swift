//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Presentation
import Validation
import XCTest

final class ValidationCompositeTests: XCTestCase {
    func test_should_return_nil_if_validation_succeed() {
        let sut = makeSut(validations: [ValidationSpy()])
        XCTAssertNil(sut.validade(data: ["name": "test"]))
    }
    
    func test_should_return_error_if_validation_fails() {
        let validation = ValidationSpy()
        let sut = makeSut(validations: [validation])
        validation.simulateError(message: "Invalid data")
        let message = sut.validade(data: ["name": "test"])
        XCTAssertEqual(message, "Invalid data")
    }
    
    func test_should_return_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError(message: "ValidationSpy2 Invalid data")
        validationSpy3.simulateError(message: "ValidationSpy3 Invalid data")
        let message = sut.validade(data: ["name": "test"])
        XCTAssertEqual(message, "ValidationSpy2 Invalid data")
    }
    
    func test_validate_should_call_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "test"]
        _ = sut.validade(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [Validation]) -> ValidationComposite {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut)
        return sut
    }
}
