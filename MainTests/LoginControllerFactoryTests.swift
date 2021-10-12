//
//  LoginControllerFactoryTests.swift
//  MainTests
//
//  Created by Luiz Diniz Hammerli on 11/10/21.
//

import Foundation
import XCTest
import UI
import Validation
@testable import Main

final class LoginControllerFactoryTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, authenticationSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.login?(makeLoginViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            authenticationSpy.completeWithError(error: .invalidData)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_compose_with_correct_validation() {
        let validations = makeLoginValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", validator: EmailValidatorSpy()))
        XCTAssertEqual(validations[2] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"))
    }
}

extension LoginControllerFactoryTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (LoginViewController, AuthenticationSpy){
        let authenticationSpy = AuthenticationSpy()
        let sut = makeLoginController(with: MainQueueDispatchDecorator(instance: authenticationSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
//        checkMemoryLeak(for: authenticationSpy, file: file, line: line)

        return (sut, authenticationSpy)
    }
}
