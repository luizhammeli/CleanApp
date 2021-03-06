//
//  SceneDelegate.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 19/09/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navController = CustomNavigationController()
        let welcomeController = makeWelcomeController(navController: navController)
        navController.setRootViewController(welcomeController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
