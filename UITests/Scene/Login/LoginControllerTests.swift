//
//  LoginControllerTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 11/10/21.
//

import XCTest
import Presentation
@testable import UI

final class LoginControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertFalse(makeSut().loadingIndicator.isAnimating)
    }
    
    func test_sut_implements_loadindView_protocol() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView_protocol() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_loginButton_should_call_login_with_correct_data() {
        var loginViewModel: LoginViewModel?
        let sut = makeSut { loginViewModel = $0 }
        sut.emailTextField.text = "test@gmail.com"
        sut.passwordTextField.text = "password123"
        
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        
        sut.submitButton.simulateTap()
        XCTAssertEqual(loginViewModel, .init(email: email, password: password))
    }
    
}

extension LoginControllerTests {
    private func makeSut(_ loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()!
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
