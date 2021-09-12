//
//  SignupViewControllerTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 12/09/21.
//

import XCTest
@testable import UI

class SignupViewControllerTests: XCTestCase {
    func testExample() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.loadingIndicator.isAnimating)        
    }
    
    private func makeSut() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
