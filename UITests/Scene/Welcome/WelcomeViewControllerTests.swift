//
//  WelcomeViewControllerTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 12/10/21.
//

import XCTest
import Presentation
@testable import UI

final class WelcomeViewControllerTests: XCTestCase {
    func test_loginButton_should_call_login() {
        let (sut, welcomeSpy) = makeSut()
        sut.loginButton.simulateTap()
        
        XCTAssertEqual(welcomeSpy.clicksCount, 1)
    }
    
    func test_signupButton_should_call_signup() {
        let (sut, welcomeSpy) = makeSut()
        sut.signupButton.simulateTap()
        
        XCTAssertEqual(welcomeSpy.clicksCount, 1)
    }
}

extension WelcomeViewControllerTests {
    private func makeSut() -> (WelcomeViewController, ButtonSpy) {
        let sut = WelcomeViewController.instantiate()!
        let welcomeSpy = ButtonSpy()
        sut.login = welcomeSpy.action
        sut.signup = welcomeSpy.action
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return (sut, welcomeSpy)
    }
}

final class ButtonSpy {
    var clicksCount = 0
    
    func action() {
        clicksCount += 1
    }
}
