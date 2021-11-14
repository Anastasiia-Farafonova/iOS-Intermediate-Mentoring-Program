//
//  NoteListCoordinatorMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 21.11.2021.
//

import Foundation
@testable import Notes

class NoteListCoordinatorMock: Coordinator, NoteListCoordinatorProtocol {
    var noteCreationShown = false
    var receivedNote: NoteProtocol?
    var noteListCoordinatoeWasStarted = false
    
    func start() {
        noteListCoordinatoeWasStarted = true
    }
    
    func showNoteCreation() {
        noteCreationShown = true
    }
    
    func showNoteDetails(_ note: NoteProtocol) {
        receivedNote = note
    }
}
