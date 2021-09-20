//
//  MainTests.swift
//  MainTests
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import XCTest
@testable import Main

class SignUpIntegrationTests: XCTestCase {
    func test_ui_presentation_integration_should_not_create_memory_leaks() {
        let sut = SignUpComposer.composeController(with: AddAcountSpy())
        checkMemoryLeak(for: sut)        
    }
}
