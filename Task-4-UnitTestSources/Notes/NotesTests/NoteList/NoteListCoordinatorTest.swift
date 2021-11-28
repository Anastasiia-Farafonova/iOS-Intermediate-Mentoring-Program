//
//  NoteListCoordinatorTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import XCTest
@testable import Notes

class NoteListCoordinatorTest: XCTestCase {
    var coordinator: NoteListCoordinator!
    var factory: CoordinatorFactoryMock!
    var router: RouterMock!
    var database: DatabaseProtocol!
    
    override func setUpWithError() throws {
        router = RouterMock()
        database = DatabaseMock()
        factory = CoordinatorFactoryMock()
        
        coordinator = NoteListCoordinator(router: router, folderId: ObjectIdStub(), database: database, factory: factory)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        router = nil
        database = nil
        factory = nil
    }
    
    func testCoordinatorWasStarted() {
        coordinator.start()
        
        XCTAssertTrue(router.viewControllerWasPushed)
    }
    
    func testNoteCreatingWasShown() {
        coordinator.showNoteCreation()
        
        XCTAssertTrue(factory.noteDetailsCoordinator.coordinatorWasStarted)
    }
    
    func testNoteDetailsWasShown() {
        let note = NoteStub()
        
        coordinator.showNoteDetails(note)
        
        XCTAssertIdentical(note, factory.noteDetailsCoordinator.receivedNote)
    }
}
