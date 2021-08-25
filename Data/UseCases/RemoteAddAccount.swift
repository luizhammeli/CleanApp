//
//  RemoteAddAcount.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation
import Domain

public class RemoteAddAccount: AddAccount {
    private let url: URL
    private let postClient: HttpPostClient
    
    init(url: URL, postClient: HttpPostClient) {
        self.url = url
        self.postClient = postClient
    }
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        postClient.post(to: url, with: addAccountModel.toData()) { result in
            switch result {
            case .failure:
                completion(.failure(.unexpected))
            case .success(let data):
                guard let accountModel: AccountModel = data.toObject() else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(accountModel))
            }
        }
    }
}
