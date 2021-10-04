//
//  RemoteAddAcountTests.swift
//  DataTests
//
///Users/luizdinizhammerli/Library/Mobile Documents/com~apple~CloudDocs/Documents/CleanApp/Data  Created by Luiz Diniz Hammerli on 16/08/21.
//

import XCTest
@testable import Domain
@testable import Data

class RemoteAddAcountTests: XCTestCase {
    func test_add_should_call_HttpClient_with_correct_url() throws {
        let (sut, postClient) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()) { result in }
        XCTAssertEqual(postClient.urls, [makeFakeURL()])
    }
    
    func test_add_should_call_HttpClient_with_correct_data() throws {
        let (sut, postClient) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()) { result in }
        XCTAssertEqual(postClient.data, makeAddAccountModel().toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_error() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.unexpected)) {
            postClient.completeWithError(error: .noConnectivity)
        }
    }
    
    func test_add_should_complete_with_email_in_use_error_if_client_completes_with_forbidden_error() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.emailInUse)) {
            postClient.completeWithError(error: .forbidden)
        }
    }
    
    func test_add_should_complete_with_success_if_client_completes_with_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .success(makeAccountModel())) {
            postClient.completeWithSuccess(data: makeAccountModel().toData()!)
        }
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.invalidData)) {
            postClient.completeWithSuccess(data: makeInvalidData())
        }
    }
    
    func test_add_should_not_complete_if_client_has_been_deallocated() throws {
        let postClient = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeFakeURL(), postClient: postClient)
        var result: AddAccount.Result?
        sut?.add(addAccountModel: makeAddAccountModel(), completion: { result = $0 })
        sut = nil
        postClient.completeWithSuccess(data: makeInvalidData())
        XCTAssertNil(result)
    }
}

extension RemoteAddAcountTests {
    func makeSut(url: URL = URL(string: "https://www.any-url.com")!) -> (RemoteAddAccount, HttpClientSpy) {
        let postClient = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, postClient: postClient)
        checkMemoryLeak(for: sut)
        return (sut, postClient)
    }
    
    func expect(sut: RemoteAddAccount, with expectedResult: AddAccount.Result, when action: @escaping (() -> Void), file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
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
