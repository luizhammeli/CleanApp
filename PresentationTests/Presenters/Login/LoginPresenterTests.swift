//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 10/10/21.
//

import XCTest
import Presentation
import Domain

final class LoginPresenterTests: XCTestCase {
    func test_should_call_validade_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: viewModel.toJson()!).isEqual(to: validationSpy.data!))
    }
    
    func test_should_show_error_message_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let viewModel = makeLoginViewModel()
        validationSpy.simulateError()
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
        }
        sut.login(viewModel: viewModel)
    }
    
    func test_should_call_auth_method_with_correct_values() throws {
        let authentication = AuthenticationSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, authentication: authentication)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(authentication.authenticationModel, makeAuthenticationModel())
    }
    
    func test_should_show_loadingView_before_and_after_authenticate() {
        let loadingView = LoadingViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(loadingView: loadingView, authentication: authenticationSpy)
        let expectation = XCTestExpectation(description: "waiting")
        loadingView.observe { viewModel in
            XCTAssertEqual(viewModel, makeLoadingViewModel(isLoading: true))
            expectation.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [expectation], timeout: 1)
        
        let expectation2 = XCTestExpectation(description: "waiting")
        loadingView.observe { viewModel in
            XCTAssertEqual(viewModel, makeLoadingViewModel(isLoading: false))
            expectation2.fulfill()
        }
        authenticationSpy.completeWithError(error: .unexpected)
        wait(for: [expectation2], timeout: 1)
    }
    
    func test_should_show_generic_error_message_if_addAccount_fails() throws {
        let alertView = AlertViewSpy()
        let authentication = AuthenticationSpy()
        let sut = makeSut(alertView: alertView, authentication: authentication)
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, makeGenericLoginErrorAlertViewModel())
            expectation.fulfill()
        }
        sut.login(viewModel: makeLoginViewModel())
        authentication.completeWithError(error: .unexpected)
        wait(for: [expectation], timeout: 1)
    }
}

extension LoginPresenterTests {
    private func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                         loadingView: LoadingView = LoadingViewSpy(),
                         authentication: Authentication = AuthenticationSpy(),
                         validation: Validation = ValidationSpy(),
                         file: StaticString = #filePath,
                         line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation, alertView: alertView, loadingView: loadingView, authentication: authentication)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
