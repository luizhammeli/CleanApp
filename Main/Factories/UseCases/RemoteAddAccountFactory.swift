//
//  File.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 04/10/21.
//

import Data
import Domain

func makeRemoteAddAccount(postClient: HttpPostClient = makeAlamofireAdapter()) -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeApiURL(with: "signup"), postClient: postClient)
    return MainQueueDispatchDecorator(instance: remoteAddAccount)
}
