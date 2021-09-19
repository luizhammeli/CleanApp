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
    static func makeRemoteAddAccount() -> RemoteAddAccount {
        let postClient = AlamofireAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        return RemoteAddAccount(url: url, postClient: postClient)
    }
}
