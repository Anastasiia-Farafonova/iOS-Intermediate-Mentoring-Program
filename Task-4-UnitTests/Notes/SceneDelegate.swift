//
//  SceneDelegate.swift
//  Notes
//
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
    
    private lazy var appCoordinator = AppCoordinator(factory: CoordinatorFactory(),
                                                     router: Router(rootViewController: rootController),
                                                     database: Database())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if ProcessInfo().arguments.contains("--UnitTests") {
            return
        }
        
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
    }
}
