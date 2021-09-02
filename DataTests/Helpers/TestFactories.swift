//
//  TestFactories.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 26/08/21.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("Test Element".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\": \"Rodrigo\"}".utf8)
}

func makeFakeURL() -> URL {
    return URL(string: "https://www.any-url.com")!
}
