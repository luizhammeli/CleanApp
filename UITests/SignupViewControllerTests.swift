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
    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        sut.loadViewIfNeeded()
        XCTAssertFalse(sut.loadingIndicator.isAnimating)        
    }
    
    func test_sut_implements_loadindView_protocol() throws {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alertView_protocol() throws {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
}

extension SignupViewControllerTests {
    private func makeSut() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        return sut
    }
}
