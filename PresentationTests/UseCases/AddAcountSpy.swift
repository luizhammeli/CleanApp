//
//  AddAcountSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//
import Domain

final class AddAcountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithSucess(accountModel: AccountModel = makeAccountModel()) {
        completion?(.success(accountModel))
    }
}
