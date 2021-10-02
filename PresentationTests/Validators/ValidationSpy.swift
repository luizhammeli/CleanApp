//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 28/09/21.
//

import Foundation
import Presentation

final class ValidationSpy: Validation {
    var data: [String : Any]?
    var message: String?
    func validade(data: [String : Any]?) -> String? {
        self.data = data
        return message
    }
    
    func simulateError() {
        message = "Erro"
    }
}
