//
//  SceneDelegate.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 11.10.2021.
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
    
    private lazy var applicationCoordinator = ApplicationCoordinator(router: Router(rootViewController: rootController))
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootController
        rootController.view.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        applicationCoordinator.start()
    }
}
