//
//  TestFactories.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 26/08/21.
//

import Foundation

func makeInvalidData() -> Data {
    Data("Test Element".utf8)
}

func makeFakeURL() -> URL {
    URL(string: "https://www.any-url.com")!
}
