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
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_email_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Email")
        let signupViewModel = makeSignUpViewModel(email: nil)
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Senha")
        let signupViewModel = makeSignUpViewModel(password: nil)
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_confirm_password_is_not_provided() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeRequiredAlertViewModel(fieldName: "Confirmar Senha")
        let signupViewModel = makeSignUpViewModel(passwordConfirmation: nil)
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_match_with_confirm_password() throws {
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView)
        let alertViewModel = makeValidationAlertViewModel(message:  "Os campos Senha e Confirmar Senha devem ser iguais")
        let signupViewModel = makeSignUpViewModel(passwordConfirmation: "1234568")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_email_is_not_valid() throws {
        let emailValidator = EmailValidatorSpy()
        let alertView = AlertViewSpy()
        let sut = makeSut(alertView: alertView, emailValidator: emailValidator)
        let alertViewModel = makeValidationAlertViewModel(message:  "O Email inserido é inválido")
        let signupViewModel = makeSignUpViewModel()
        emailValidator.setAsInvalid()
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
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
        let sut = makeSut(addAccount: addAccount)
        sut.signup(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccount.addAccountModel, makeAddAccountModel())
    }
    
    func test_should_show_error_message_if_addAccount_fails() throws {
        let alertView = AlertViewSpy()
        let addAccount = AddAcountSpy()
        let sut = makeSut(alertView: alertView, addAccount: addAccount)
        sut.signup(viewModel: makeSignUpViewModel())
        addAccount.completeWithError(error: .unexpected)
        XCTAssertEqual(alertView.viewModel, makeSignupAlertViewModel())
    }
}

extension PresentationTests {
    private func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccount = AddAcountSpy()) -> SignupPresenter {
        let signupPresenter = SignupPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        return signupPresenter
    }
    
    private func makeSignUpViewModel(name: String? = "Test User", email: String? = "teste@mail.com", password: String? = "passwordTest", passwordConfirmation: String? =  "passwordTest") -> SignupViewModel {
        return SignupViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    private func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
    }
    
    private func makeValidationAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: message)
    }
    
    private func makeSignupAlertViewModel() -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: "Ocorreu um erro ao realizar o cadastro, tente novamente.")
    }
}

final class AlertViewSpy: AlertView {
    var viewModel: AlertViewModel?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}

final class EmailValidatorSpy: EmailValidator {
    private var isValid = true
    var email: String?
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func setAsInvalid() {
        isValid = false
    }
}

final class AddAcountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(error: DomainError) {
        completion?(.failure(error))
    }
}
