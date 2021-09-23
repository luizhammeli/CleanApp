//
//  MainTests.swift
//  MainTests
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import XCTest
import UI
@testable import Main

final class SignUpIntegrationTests: XCTestCase {
    func test_ui_presentation_integration_should_not_create_memory_leaks() {        
        let (sut, addAcountSpy) = makeSut()
        sut.loadViewIfNeeded()
        addAcountSpy.completeWithError(error: .invalidData)        
    }
}

extension SignUpIntegrationTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (SignUpViewController, AddAcountSpy){
        let addAcountSpy = AddAcountSpy()
        let sut = SignUpComposer.composeController(with: addAcountSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAcountSpy, file: file, line: line)

        return (sut, addAcountSpy)
    }
}
