//
//  RemoteAddAcount.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation
import Domain

class RemoteAddAccount: AddAccount {
    private let url: URL
    private let postClient: HttpPostClient
    
    init(url: URL, postClient: HttpPostClient) {
        self.url = url
        self.postClient = postClient
    }
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void) {
        postClient.post(to: url, with: addAccountModel.toData()) { result in }
    }
}
