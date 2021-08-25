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
    
    func test_add_should_complete_with_success_if_client_completes_with_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .success(self.makeAccountModel())) {
            postClient.completeWithSuccess(data: self.makeAccountModel().toData()!)
        }
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() throws {
        let (sut, postClient) = makeSut()
        expect(sut: sut, with: .failure(.invalidData)) {
            postClient.completeWithSuccess(data: self.makeInvalidData())
        }
    }
    
    func expect(sut: RemoteAddAccount, with expectedResult: Result<AccountModel, DomainError>, when action: @escaping (() -> Void), file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)):
                XCTAssertEqual(expectedAccount, receivedAccount)
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}

extension RemoteAddAcountTests {
    func makeSut(url: URL = URL(string: "https://www.any-url.com")!) -> (RemoteAddAccount, HttpClientSpy) {
        let postClient = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, postClient: postClient)
        return (sut, postClient)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "Test User", email: "teste@mail.com", passsword: "passwordTest", passswordConfirmation: "passwordTest")
    }
    
    func makeAccountModel() -> AccountModel {
        AccountModel(id: "123", name: "Test User", email: "teste@mail.com", passsword: "passwordTest")
    }
    
    func makeInvalidData() -> Data {
        Data("Test Element".utf8)
    }
    
    func makeFakeURL() -> URL {
        URL(string: "https://www.any-url.com")!
    }
}

class HttpClientSpy: HttpPostClient {
    var urls: [URL] = []
    var data: Data?
    var completion: ((Result<Data, HttpError>) -> Void?)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithSuccess(data: Data) {
        completion?(.success(data))
    }
}

