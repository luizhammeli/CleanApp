//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Luiz Diniz Hammerli on 09/10/21.
//

import Foundation
import Domain

final class RemoteAuthentication: Authentication {
    private let url: URL
    private let postClient: HttpPostClient
    
    public init(url: URL, postClient: HttpPostClient) {
        self.url = url
        self.postClient = postClient
    }
    
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        postClient.post(to: url, with: authenticationModel.toData()) { [weak self] result in
            guard self != nil else { return }            
            switch result {
            case .success(let data):
                guard let accountModel: AccountModel = data?.toObject() else { return completion(.failure(.invalidData)) }
                completion(.success(accountModel))
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.expiredSession))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
    
}
