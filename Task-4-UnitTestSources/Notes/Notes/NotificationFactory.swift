//
//  NotificationFactory.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 23.01.2022.
//

import Foundation
import CoreData
import UserNotifications

class NotificationFactory {
    private enum Const {
        static let lastNoteTitle = "Last edited note"
        static let lastNoteId = "last_note"
        static let newNoteId = "new_note"
        static let newNoteTitle = "Create a new note"
        static let newNoteBody = "You don't have any notes yet. Create a new one."
        static let randomNoteId = "random_note"
        static let randomNoreTitle = "Random note notification"
        static let randomNoteBody = "You haven't viewed this note for a long time."
        static let objectIdKey = "objectID"
        static let notificationTime: Double = 5
    }
    
    func createTerminatedNotifications() {
        if let lastEditedNote = lastEditedNote() {
            lastEditedNoteNotification(note: lastEditedNote)
        } else {
            createNewNoteNotification()
        }
        
    }
    
    func createMinimazingNotification() {
        guard let note = randomNote() else { return }
        openCertainNote(by: note.objectID)
    }
    
    private func lastEditedNote() -> Note? {
        return Note.getLastCreatedNote()
    }
    
    private func randomNote() -> Note? {
        return Note.getRandomNote()
    }
    
    private func lastEditedNoteNotification(note: Note) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = Const.lastNoteTitle
        notificationContent.body = note.body ?? ""
        notificationContent.userInfo[Const.objectIdKey] = note.objectID.uriRepresentation().absoluteString
        
        addRequest(with: notificationContent)
    }
    
    private func createNewNoteNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = Const.newNoteTitle
        notificationContent.body = Const.newNoteBody
        
        addRequest(with: notificationContent)
    }
    
    private func openCertainNote(by id: NSManagedObjectID) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = Const.randomNoreTitle
        notificationContent.body = Const.randomNoteBody
        notificationContent.userInfo[Const.objectIdKey] = id.uriRepresentation().absoluteString
        
        addRequest(with: notificationContent)
    }
    
    private func addRequest(with notificationContent: UNMutableNotificationContent) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Const.notificationTime, repeats: false)
        let request = UNNotificationRequest(identifier: Const.randomNoteId, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
