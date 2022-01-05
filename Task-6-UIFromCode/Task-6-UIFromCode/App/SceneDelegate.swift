//
//  SceneDelegate.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 05.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootController: UINavigationController {
        guard let window = window,
              let rootViewController = window.rootViewController as? UINavigationController else {
            return UINavigationController()
        }
        
        return rootViewController
    }
    
    private lazy var appCoordinator = AppCoordinator(router: Router(rootViewController: rootController))
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
    }
}
