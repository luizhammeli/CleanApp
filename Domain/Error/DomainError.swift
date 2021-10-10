//
//  DomainError.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 21/08/21.
//

import Foundation

public enum DomainError: Error {
    case unexpected
    case invalidData
    case emailInUse
    case expiredSession
}
