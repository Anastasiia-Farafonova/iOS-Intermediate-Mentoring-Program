//
//  NotificationCenterDelegate.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 23.01.2022.
//

import UIKit

class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    let router: Router

    init(router: Router) {
        self.router = router
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        guard let objectIDUrl = response.notification.request.content.userInfo["objectID"] as? String,
              let url = URL(string: objectIDUrl),
              let objectID = Database.shared.viewContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url),
              let note = Database.shared.viewContext.object(with: objectID) as? Note else { return }
              
        showNote(note)
        completionHandler()
    }
    
    private func showNote(_ note: Note) {
        guard let folderId = note.folder?.objectID else { return }
        
        let noteDetailsCoordinator = NoteDetailsCoordinator(router: router, folderId: folderId)
        noteDetailsCoordinator.start(note)
    }
}
