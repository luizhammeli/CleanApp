//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import XCTest
//@testable import Presentation

final class SignupPresenter {
    private let alertView: AlertView
    
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signup(viewModel: SignupViewModel) {
        if let error = validate(viewModel: viewModel) {
            let alertViewModel = AlertViewModel(title: "Falha na validação", message: error)
            return alertView.showMessage(viewModel: alertViewModel)
        }
    }
    
    private func validate(viewModel: SignupViewModel) -> String? {
        guard let name = viewModel.name, !name.isEmpty else {
            return "O campo Nome é obrigatório"
        }
        guard let email = viewModel.email, !email.isEmpty else {
            return "O campo Email é obrigatório"
        }
        guard let password = viewModel.password, !password.isEmpty else {
            return "O campo Senha é obrigatório"
        }
        guard let passwordConfirmation = viewModel.passwordConfirmation, !passwordConfirmation.isEmpty else {
            return "O campo Confirmar Senha é obrigatório"
        }
        guard password == passwordConfirmation else {
            return "Os campos Senha e Confirmar Senha devem ser iguais"
        }
        
        return nil
    }
}

public struct SignupViewModel {
    public let name: String?
    public let email: String?
    public let password: String?
    public let passwordConfirmation: String?
}

public struct AlertViewModel: Equatable {
    public let title: String
    public let message: String
}

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

final class PresentationTests: XCTestCase {
    func test_should_show_error_message_if_name_is_not_provided() throws {
        let (sut, alertView) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório")
        let signupViewModel = makeSignUpViewModel(email: "test@test.com", password: "123456", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_email_is_not_provided() throws {
        let (sut, alertView) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", password: "123456", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_provided() throws {
        let (sut, alertView) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", passwordConfirmation: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_confirm_password_is_not_provided() throws {
        let (sut, alertView) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatório")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
    
    func test_should_show_error_message_if_password_is_not_equal_to_confirm_password() throws {
        let (sut, alertView) = makeSut()
        let alertViewModel = AlertViewModel(title: "Falha na validação", message: "Os campos Senha e Confirmar Senha devem ser iguais")
        let signupViewModel = makeSignUpViewModel(name: "Test Name", email: "test@test.com", password: "123456", passwordConfirmation: "1234568")
        sut.signup(viewModel: signupViewModel)
        XCTAssertEqual(alertView.viewModel, alertViewModel)
    }
}

extension PresentationTests {
    private func makeSut() -> (SignupPresenter, AlertViewSpy) {
        let alertView = AlertViewSpy()
        let signupPresenter = SignupPresenter(alertView: alertView)
        return (signupPresenter, alertView)
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
