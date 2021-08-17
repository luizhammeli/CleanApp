//
//  HttpPostClient.swift
//  DataTests
//
//  Created by Luiz Diniz Hammerli on 16/08/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}
