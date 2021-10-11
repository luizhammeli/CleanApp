//
//  LoginControllerTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 11/10/21.
//

import XCTest
import Presentation
@testable import UI

class LoginControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertFalse(makeSut().loadingIndicator.isAnimating)
    }
    
    func test_sut_implements_loadindView_protocol() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView_protocol() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
}

extension LoginControllerTests {
    private func makeSut(_ signUpSpy: ((SignupViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()!
        sut.loadViewIfNeeded()
        return sut
    }
}
