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
        alertView.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeSignupAlertViewModel())
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        addAccount.completeWithError(error: .unexpected)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should_() throws {
        let loadingView = LoadingViewSpy()
        let sut = makeSut(loadingView: loadingView)
        let expectation = expectation(description: "waiting")
        loadingView.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeLoadingViewModel(isLoading: true))
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        wait(for: [expectation], timeout: 1)
    }
    
    func test_should__2() throws {
        let loadingView = LoadingViewSpy()
        let addAccount = AddAcountSpy()
        let sut = makeSut(loadingView: loadingView, addAccount: addAccount)
        let expectation = expectation(description: "waiting")
        loadingView.observe(when: false) { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeLoadingViewModel(isLoading: false))
            expectation.fulfill()
        }
        sut.signup(viewModel: makeSignUpViewModel())
        addAccount.completeWithError(error: .unexpected)
        wait(for: [expectation], timeout: 1)
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
    
    private func makeLoadingViewModel(isLoading: Bool) -> LoadingViewModel {
        return .init(isLoading: isLoading)
    }
}

final class AlertViewSpy: AlertView {
    private var viewModel: AlertViewModel?
    var emiter: ((AlertViewModel?) -> Void)?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        emiter?(viewModel)
    }
    
    func observe(completion: @escaping (AlertViewModel?) -> Void) {
        self.emiter = completion
    }
}

final class LoadingViewSpy: LoadingView {
    private var viewModel: LoadingViewModel?
    var emiter: ((LoadingViewModel?) -> Void)?
    var executeEmiterWhenIsLoading: Bool = true
    
    func showLoader(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        if executeEmiterWhenIsLoading == viewModel.isLoading  {
            emiter?(viewModel)
        }
    }
    
    func observe(when isLoading: Bool = true, completion: @escaping (LoadingViewModel?) -> Void) {
        self.emiter = completion
        self.executeEmiterWhenIsLoading = isLoading
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
