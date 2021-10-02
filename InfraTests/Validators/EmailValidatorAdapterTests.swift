//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import XCTest
import Validation

final class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "luiz"))
        XCTAssertFalse(sut.isValid(email: "luiz@"))
        XCTAssertFalse(sut.isValid(email: "luiz@gmail"))
        XCTAssertFalse(sut.isValid(email: "@gmail.com"))
        XCTAssertFalse(sut.isValid(email: ".com.br"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.com.br"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.org"))
        XCTAssertTrue(sut.isValid(email: "luiz@gmail.org.br"))
    }
}

private extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        let sut = EmailValidatorAdapter()
        return sut
    }
}
