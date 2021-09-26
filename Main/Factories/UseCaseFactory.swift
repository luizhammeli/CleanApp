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
import SwiftUI

final class UseCaseFactory {
    private static let httpPostClient = AlamofireAdapter()
    private static let apiBaseURL = Environment.variable(for: .apiBaseURL)
    
    static func makeURL(with path: String) -> URL {
        return URL(string: "\(apiBaseURL)\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {        
        let remoteAddAccount = RemoteAddAccount(url: makeURL(with: "signup"), postClient: httpPostClient)
        return MainQueueDispatchDecorator(instance: remoteAddAccount)
    }    
}
