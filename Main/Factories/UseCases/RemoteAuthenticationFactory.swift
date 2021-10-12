//
//  makeRemoteAuthentication.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 11/10/21.
//

import Data
import Domain

func makeRemoteAuthentication(postClient: HttpPostClient = makeAlamofireAdapter()) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiURL(with: "login"), postClient: postClient)
    return MainQueueDispatchDecorator(instance: remoteAuthentication)
}
