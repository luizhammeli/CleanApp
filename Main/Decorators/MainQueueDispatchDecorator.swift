//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 26/09/21.
//

import Foundation
import Domain

final class MainQueueDispatchDecorator<T> {
    let instance: T
    
    init(instance: T) {
        self.instance = instance
    }
    
    private func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        self.instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: Authentication where T: Authentication {
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.instance.auth(authenticationModel: authenticationModel) { result in
            self.dispatch {
                completion(result)
            }
        }
    }
}
