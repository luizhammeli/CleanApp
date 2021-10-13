//
//  WelcomeRouterTests.swift
//  UITests
//
//  Created by Luiz Diniz Hammerli on 12/10/21.
//

import XCTest
import UI

final class WelcomeRouter {
    private let navigationController: CustomNavigationController
    private let loginFactory: () -> LoginViewController
    private let signupFactory: () -> SignUpViewController
    
    init(navigationController: CustomNavigationController, loginFactory: @escaping () -> LoginViewController, signupFactory: @escaping () -> SignUpViewController) {
        self.navigationController = navigationController
        self.loginFactory = loginFactory
        self.signupFactory = signupFactory
    }
    
    func goToLogin() {
        navigationController.pushViewController(loginFactory())
    }
    
    func goToSignup() {
        navigationController.pushViewController(signupFactory())
    }
}

final class WelcomeRouterTests: XCTestCase {
    func test_goToLogin_should_calls_navigation_controller_with_login_controller() {
        let (sut, navController) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers.first! is LoginViewController)
    }
    
    func test_goToSignup_should_calls_navigation_controller_with_signup_controller() {
        let (sut, navController) = makeSut()
        sut.goToSignup()
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertTrue(navController.viewControllers.first! is SignUpViewController)
    }
}

extension WelcomeRouterTests {
    private func makeSut() -> (WelcomeRouter, CustomNavigationController) {
        let navigationController = CustomNavigationController()
        let sut = WelcomeRouter(navigationController: navigationController, loginFactory: loginFactorySpy, signupFactory: signupFactorySpy)
        checkMemoryLeak(for: sut)
        return (sut, navigationController)
    }
    
    func loginFactorySpy() -> LoginViewController {
        return LoginViewController.instantiate()!
    }
    
    func signupFactorySpy() -> SignUpViewController {
        return SignUpViewController.instantiate()!
    }
}
 
