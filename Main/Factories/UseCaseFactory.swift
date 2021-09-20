//
//  UseCaseFactory.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import Foundation
import Domain
import Infra
import Data

final class UseCaseFactory {
    private static let httpPostClient = AlamofireAdapter()
    private static let apiBaseURL = "https://fordevs.herokuapp.com/api/"
    
    static func makeURL(with path: String) -> URL {
        return URL(string: "\(apiBaseURL)\(path)")!
    }
    
    static func makeRemoteAddAccount() -> RemoteAddAccount {        
        return RemoteAddAccount(url: makeURL(with: "signup"), postClient: httpPostClient)
    }    
}
