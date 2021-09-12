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
        let sut = makeSut { viewModel in
            XCTAssertEqual(viewModel, SignupViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
        }
        
        sut.saveButton.simulateTap()
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}

extension SignupViewControllerTests {
    private func makeSut(_ signUpSpy: ((SignupViewModel) -> Void)? = nil) -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
