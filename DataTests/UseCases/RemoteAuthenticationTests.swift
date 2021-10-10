//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 09/10/21.
//

import Foundation

import XCTest
@testable import Domain
@testable import Data

final class RemoteAuthenticationTests: XCTestCase {
    func test_auth_should_call_HttpClient_with_correct_url() throws {
        let (sut, postClient) = makeSut()
        sut.auth(authenticationModel: makeAuthenticationModel()) { result in }
        XCTAssertEqual(postClient.urls, [makeFakeURL()])
    }
    
    func test_auth_should_call_HttpClient_with_correct_data() throws {
        let (sut, postClient) = makeSut()
        sut.auth(authenticationModel: makeAuthenticationModel()) { result in }
        XCTAssertEqual(postClient.data, makeAuthenticationModel().toData())
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_error() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.unexpected)) {
            postClient.completeWithError(error: .noConnectivity)
        }
    }
    
    func test_add_should_complete_with_password_incorrect_error_if_client_completes_with_unauthorized_error() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.passwordIncorrect)) {
            postClient.completeWithError(error: .unauthorized)
        }
    }
    
    func test_auth_should_complete_with_success_if_client_completes_with_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .success(makeAccountModel())) {
            postClient.completeWithSuccess(data: makeAccountModel().toData()!)
        }
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.invalidData)) {
            postClient.completeWithSuccess(data: makeInvalidData())
        }
    }
    
    func test_auth_should_not_complete_if_client_has_been_deallocated() throws {
        let postClient = HttpClientSpy()
        var sut: RemoteAuthentication? = RemoteAuthentication(url: makeFakeURL(), postClient: postClient)
        var result: AddAccount.Result?
        sut?.auth(authenticationModel: makeAuthenticationModel(), completion: { result = $0 })
        sut = nil
        postClient.completeWithSuccess(data: makeInvalidData())
        XCTAssertNil(result)
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = makeFakeURL()) -> (RemoteAuthentication, HttpClientSpy) {
        let postClient = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, postClient: postClient)
        checkMemoryLeak(for: postClient)
        checkMemoryLeak(for: sut)
        return (sut, postClient)
    }
    
    func expect(sut: RemoteAuthentication, with expectedResult: Authentication.Result, when action: @escaping (() -> Void), file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)):
                XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
