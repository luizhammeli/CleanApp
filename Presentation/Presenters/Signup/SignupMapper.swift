//
//  SignupMapper.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Domain

final class SignupMapper {
    static func toAddAccountModel(with signupViewModel: SignupViewModel) -> AddAccountModel? {
        guard let name = signupViewModel.name,
              let email = signupViewModel.email,
              let password = signupViewModel.password,
              let passwordConfirmation = signupViewModel.passwordConfirmation else { return nil }
        
        return AddAccountModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
}
