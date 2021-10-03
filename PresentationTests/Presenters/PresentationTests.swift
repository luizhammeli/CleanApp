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
    
    func test_should_call_validade_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signup(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: viewModel.toJson()!).isEqual(to: validationSpy.data!))
    }
    
    func test_should_show_error_message_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        validationSpy.simulateError()
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
        }
        sut.signup(viewModel: viewModel)
    }
}

extension PresentationTests {
    private func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                         loadingView: LoadingView = LoadingViewSpy(),
                         addAccount: AddAccount = AddAcountSpy(),
                         validation: Validation = ValidationSpy(),
                         file: StaticString = #filePath,
                         line: UInt = #line) -> SignupPresenter {
        let sut = SignupPresenter(alertView: alertView, loadingView: loadingView, addAccount: addAccount, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
