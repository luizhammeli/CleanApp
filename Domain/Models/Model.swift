//
//  Model.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation

public protocol Model: Codable {}

public extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
