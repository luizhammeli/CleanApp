//
//  ExtensionData.swift
//  Data
//
//  Created by Luiz Diniz Hammerli on 03/09/21.
//

import Foundation

public extension Data {
    func toObject<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toDictionary() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}
