//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import XCTest
import Presentation
import Domain

final class PresentationTests: XCTestCase {
    func test_should_show_error_message_if_name_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Nome")
        let signupViewModel = makeSignUpViewModel(name: nil)
        
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_error_message_if_email_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Email")
        let signupViewModel = makeSignUpViewModel(email: nil)
        
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_error_message_if_password_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Senha")
        let signupViewModel = makeSignUpViewModel(password: nil)
        
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_error_message_if_confirm_password_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Confirmar Senha")
        let signupViewModel = makeSignUpViewModel(passwordConfirmation: nil)
        
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_error_message_if_password_is_not_match_with_confirm_password() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeValidationAlertViewModel(message:  "Os campos Senha e Confirmar Senha devem ser iguais")
        let signupViewModel = makeSignUpViewModel(passwordConfirmation: "1234568")
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_error_message_if_email_is_not_valid() throws {
        let emailValidator = EmailValidatorSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, emailValidator: emailValidator)
        let alertViewModel = makeValidationAlertViewModel(message:  "O Email inserido é inválido")
        let signupViewModel = makeSignUpViewModel()
        emailValidator.setAsInvalid()
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, alertViewModel)
            expectation.fulfill()
        }
        sut.signup(viewModel: signupViewModel)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_not_show_error_message_if_email_is_valid() throws {
        let emailValidator = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidator)
        let signupViewModel = makeSignUpViewModel()
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(emailValidator.email, "teste@mail.com")
    }
    
    func test_should_call_add_method_with_correct_values() throws {
        let addAccount = AddAcountSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView,addAccount: addAccount)
        sut.signup(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccount.addAccountModel, makeAddAccountModel())
    }
    
    func test_should_show_error_message_if_addAccount_fails() throws {
        let alertView = AlertViewSpy()
        let addAccount = AddAcountSpy()
        let sut = makeSut(alertView: alertView, addAccount: addAccount)
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, makeSignupErrorAlertViewModel())
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        addAccount.completeWithError(error: .unexpected)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_success_message_if_addAccount_succeed() throws {
        let alertView = AlertViewSpy()
        let addAccount = AddAcountSpy()
        let sut = makeSut(alertView: alertView, addAccount: addAccount)
        let expectation = expectation(description: "waiting")
        alertView.observe { viewModel in
            XCTAssertEqual(viewModel, makeSignupSuccessAlertViewModel(message: "Conta criada com sucesso."))
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        addAccount.completeWithSucess()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_show_loadingView_before_and_after_addAccount() {
        let loadingView = LoadingViewSpy()
        let addAccount = AddAcountSpy()
        let sut = makeSut(loadingView: loadingView, addAccount: addAccount)
        let expectation = XCTestExpectation(description: "waiting")
        loadingView.observe { viewModel in
            XCTAssertEqual(viewModel, makeLoadingViewModel(isLoading: true))
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        wait(for: [expectation], timeout: 1)
                
        let expectation2 = XCTestExpectation(description: "waiting")
        loadingView.observe { viewModel in
            XCTAssertEqual(viewModel, makeLoadingViewModel(isLoading: false))
            expectation2.fulfill()
        }
        addAccount.completeWithError(error: .unexpected)
        wait(for: [expectation2], timeout: 1)
    }
}

extension PresentationTests {
    private func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                         loadingView: LoadingView = LoadingViewSpy(),
                         emailValidator: EmailValidatorSpy = EmailValidatorSpy(),
                         addAccount: AddAccount = AddAcountSpy(),
                         file: StaticString = #filePath,
                         line: UInt = #line) -> SignupPresenter {
        let sut = SignupPresenter(alertView: alertView, loadingView: loadingView, emailValidator: emailValidator, addAccount: addAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
