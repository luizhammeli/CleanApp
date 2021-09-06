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
    func test_add_account() throws {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let postClient = AlamofireAdapter()
        let addAccount = RemoteAddAccount(url: url, postClient: postClient)
        let name = "test_user_api_\(UUID().description)"
        let addAccountModel = AddAccountModel(name: "Teste Nome", email: "\(name)@gmail.com", password: "teste123", passwordConfirmation: "teste123")
        let expectation = expectation(description: "waiting")
        addAccount.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .success(let accountModel):
                XCTAssertNotNil(accountModel.accessToken)
                XCTAssertEqual(accountModel.name, addAccountModel.name)                
            case .failure(let error):
                XCTFail("Should complete with success instead \(error) failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
