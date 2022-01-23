//
//  SceneDelegate.swift
//  Notes
//
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let notificationFactory = NotificationFactory()
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
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        
        guard let response = connectionOptions.notificationResponse else { return }
        
        if let objectIDUrl = response.notification.request.content.userInfo["objectID"] as? String {
            showNoteWith(objectIdUrl: objectIDUrl)
        } else {
            showNewNote()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        notificationFactory.createTerminatedNotifications()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        notificationFactory.createMinimazingNotification()
    }
    
    private func showNewNote() {
        appCoordinator.showNote(id: nil)
    }
    
    private func showNoteWith(objectIdUrl: String) {
        if let url = URL(string: objectIdUrl),
           let objectID = Database.shared.viewContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) {
            appCoordinator.showNote(id: objectID)
        }
    }
}
