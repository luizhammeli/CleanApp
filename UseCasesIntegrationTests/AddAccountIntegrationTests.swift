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

final class AddAccountIntegrationTests: XCTestCase {
    func test_add_account() {
        let addAccount = makeAddAccount()
        let model = makeAddAccountModel()
        
        let expectation = expectation(description: "waiting")
        addAccount.add(addAccountModel: model) { result in
            guard case .success(let accountModel) = result else { return XCTFail("Should complete with success instead failure") }
            XCTAssertNotNil(accountModel.accessToken)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        let expectation2 = XCTestExpectation()
        addAccount.add(addAccountModel: model) { result in
            guard case .failure(let error) = result, error == .emailInUse else { return XCTFail("Should complete with failure instead success") }
            expectation2.fulfill()
        }
        
        wait(for: [expectation2], timeout: 10)
    }
}

private extension AddAccountIntegrationTests {
    private func makeAddAccount() -> AddAccount {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let postClient = AlamofireAdapter()
        return RemoteAddAccount(url: url, postClient: postClient)
    }
    
    private func makeAddAccountModel() -> AddAccountModel {
        let email: String = "test_user_api_\(UUID().description)@gmail.com"
        return AddAccountModel(name: "Teste Nome", email: email, password: "teste123", passwordConfirmation: "teste123")
    }
}
