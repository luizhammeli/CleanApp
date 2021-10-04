//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Luiz Diniz Hammerli on 05/09/21.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {
    static var email: String = "test_user_api_\(UUID().description)@gmail.com"
    
    func test_add_account() {
        makeRequest(with: AddAccountIntegrationTests.email) { result in
            switch result {
            case .success(let accountModel):
                XCTAssertNotNil(accountModel.accessToken)
            case .failure(let error):
                XCTFail("Should complete with success instead \(error) failure")
            }
        }
    }
    
    func test_add_account_should_complete_with_email_in_use_error() {
        self.makeRequest(with: AddAccountIntegrationTests.email) { result in
            switch result {
            case .success:
                XCTFail("Should complete with failure instead success")
            case .failure(let error):
                XCTAssertEqual(error, .emailInUse)
            }
        }
    }
}

extension AddAccountIntegrationTests {
    func makeRequest(with email: String, completion: ((Result<AccountModel, DomainError>) -> Void)?) {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let postClient = AlamofireAdapter()
        let addAccount = RemoteAddAccount(url: url, postClient: postClient)
        let addAccountModel = AddAccountModel(name: "Teste Nome", email: email, password: "teste123", passwordConfirmation: "teste123")
        let expectation = expectation(description: "waiting")
        addAccount.add(addAccountModel: addAccountModel) { receivedResult in
            completion?(receivedResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func makeEmail() -> String {
        return "test_user_api_\(UUID().description)@gmail.com"
    }
}
