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
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let postClient = AlamofireAdapter()
        let addAccount = RemoteAddAccount(url: url, postClient: postClient)
        let addAccountModel = AddAccountModel(name: "Teste Nome", email: "rodrigo.manguinho@gmail.com", passsword: "teste123", passswordConfirmation: "teste123")
        let expectation = expectation(description: "waiting")
        addAccount.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .success(let accountModel):
                XCTAssertNotNil(accountModel.id)
                XCTAssertEqual(accountModel.name, addAccountModel.name)
                XCTAssertEqual(accountModel.email, addAccountModel.email)
            case .failure(let error):
                XCTFail("Should complete with success instead \(error) failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
