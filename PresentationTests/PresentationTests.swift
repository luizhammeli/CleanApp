//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import XCTest
import Presentation

final class PresentationTests: XCTestCase {
    func test_should_show_error_message_if_name_is_not_provided() throws {
        let (sut, alertView, _) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório")
        let signupViewModel = makeSignUpViewModel(email: "test@test.com", password: "123456", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_email_is_not_provided() throws {
        let (sut, alertView, _) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", password: "123456", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_provided() throws {
        let (sut, alertView, _) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_confirm_password_is_not_provided() throws {
        let (sut, alertView, _) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_match_with_confirm_password() throws {
        let (sut, alertView, _) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "Os campos Senha e Confirmar Senha devem ser iguais")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456", passwordConfirmation: "1234568")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_email_is_not_valid() throws {
        let (sut, alertView, emailValidator) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message:  "O Email inserido é inválido")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456", passwordConfirmation: "123456")
        emailValidator.isValid = false
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_not_show_error_message_if_email_is_valid() throws {
        let (sut, _, emailValidator) = makeSut()
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(emailValidator.email, "test@test.com")
    }
}

extension PresentationTests {
    private func makeSut() -> (SignupPresenter, AlertViewSpy, EmailValidatorSpy) {
        let alertView = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let signupPresenter = SignupPresenter(alertView: alertView, emailValidator: emailValidatorSpy)
        return (signupPresenter, alertView, emailValidatorSpy)
    }
    
    private func makeSignUpViewModel(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) -> SignupViewModel {
        return SignupViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
}

final class AlertViewSpy: AlertView {
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}

final class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}
