//
//  MainTests.swift
//  MainTests
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import XCTest
import UI
import Validation
@testable import Main

final class SignUpIntegrationTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, addAcountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAcountSpy.completeWithError(error: .invalidData)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_compose_with_correct_validation() {
        let validations = SignUpComposer.makeValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "name", fieldLabel: "Nome"))
        XCTAssertEqual(validations[1] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", validator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"))
        XCTAssertEqual(validations[4] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
        XCTAssertEqual(validations[5] as! CompareFieldValidation, CompareFieldValidation(fieldName: "password",
                                                                                         fieldToCompare: "passwordConfirmation",
                                                                                         fieldLabel: "Senha"))
    }
}

extension SignUpIntegrationTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (SignUpViewController, AddAcountSpy){
        let addAcountSpy = AddAcountSpy()
        let sut = SignUpComposer.composeController(with: MainQueueDispatchDecorator(instance: addAcountSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAcountSpy, file: file, line: line)

        return (sut, addAcountSpy)
    }
}
