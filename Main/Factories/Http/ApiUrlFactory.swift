//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 04/10/21.
//

import Foundation

func makeApiURL(with path: String) -> URL {
    return URL(string: "\(Environment.variable(for: .apiBaseURL))\(path)")!
}
