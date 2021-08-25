//
//  Model.swift
//  Domain
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

public extension Data {
    func toObject<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
