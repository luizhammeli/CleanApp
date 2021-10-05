//
//  SceneDelegate.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SignUpComposer.composeController()
        window?.makeKeyAndVisible()
    }
}
