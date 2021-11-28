//
//  FolderListCoordinatorTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import XCTest
@testable import Notes

class FolderListCoordinatorTest: XCTestCase {
    var router: RouterMock!
    var coordinator: FolderListCoordinator!
    var factory: CoordinatorFactoryMock!
    var database: DatabaseMock!
    
    override func setUpWithError() throws {
        router = RouterMock()
        factory = CoordinatorFactoryMock()
        database = DatabaseMock()
        coordinator = FolderListCoordinator(factory: factory, router: router, database: database)
    }

    override func tearDownWithError() throws {
        router = nil
        coordinator = nil
        factory = nil
        database = nil
    }
    
    func testsNotesListWasShown() {
        let folderId = ObjectIdStub()
        
        coordinator.showNotesList(folderId: folderId)
        
        XCTAssertTrue(factory.noteListCoordinator.noteListCoordinatoeWasStarted)
    }
    
    func testCoordinatorWasStarted() {
        coordinator.start()
        
        XCTAssertTrue(database.persistentContainerWasLoaded)
    }
}
