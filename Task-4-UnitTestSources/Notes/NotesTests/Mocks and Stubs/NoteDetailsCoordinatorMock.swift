//
//  NoteDetailsCoordinatorMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import Foundation
@testable import Notes

class NoteDetailsCoordinatorMock: NoteDetailsCoordinatorProtocol {
    var receivedNote: NoteProtocol?
    var coordinatorWasStarted = false
    
    func start(_ note: NoteProtocol) {
        receivedNote = note
    }
    
    func start() {
        coordinatorWasStarted = true
    }
}
