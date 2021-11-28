//
//  FolderListCoordinatorMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 14.11.2021.
//

import Foundation
@testable import Notes

class FolderListCoordinatorMock: FolderListCoordinatorProtocol {
    var receivedFolderId: ObjectId?
    var coordinatorWasStarted: Bool = false
    
    func start() {
        coordinatorWasStarted = true
    }
    
    func showNotesList(folderId: ObjectId) {
        receivedFolderId = folderId
    }
}
