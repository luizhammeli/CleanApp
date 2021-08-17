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
        XCTAssertEqual(postClient.url, URL(string: "https://www.any-url.com")!)
    }
    
    func test_add_should_call_HttpClient_with_correct_data() throws {
        let (sut, postClient) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()) { result in }
        XCTAssertEqual(postClient.data, makeAddAccountModel().toData())
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
}

class HttpClientSpy: HttpPostClient {
    var url: URL!
    var data: Data?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        self.url = url
        self.data = data
        completion(.success(Data()))
    }
}

