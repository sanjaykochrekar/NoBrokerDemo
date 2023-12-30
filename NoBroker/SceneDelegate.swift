//
//  SceneDelegate.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowSence = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowSence.coordinateSpace.bounds)
        window?.windowScene = windowSence
        
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

