//
//  SignupViewControllerTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 12/09/21.
//

import XCTest
import Presentation
@testable import UI

class SignupViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertFalse(makeSut().loadingIndicator.isAnimating)
    }
    
    func test_sut_implements_loadindView_protocol() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView_protocol() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_() {
        var signupViewModel: SignupViewModel?
        let sut = makeSut { signupViewModel = $0 }
        let name = sut.nameTextField.text
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        let passwordConfirmation = sut.passwordConfirmationTextField.text
        
        sut.saveButton.simulateTap()
        XCTAssertEqual(signupViewModel, .init(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
    }
}

extension SignupViewControllerTests {
    private func makeSut(_ signUpSpy: ((SignupViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instantiate()!
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
