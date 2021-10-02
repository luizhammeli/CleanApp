//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Luiz Diniz Hammerli on 02/10/21.
//

import Presentation

final class ValidationSpy: Validation {
    var message: String? = nil
    var data: [String: Any]? = nil
    
    func validade(data: [String : Any]?) -> String? {
        self.data = data
        return message
    }
    
    func simulateError(message: String) {
        self.message = message
    }
}
