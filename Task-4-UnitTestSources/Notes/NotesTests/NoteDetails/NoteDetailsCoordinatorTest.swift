//
//  NoteDetailsCoordinatorTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import XCTest
@testable import Notes

class NoteDetailsCoordinatorTest: XCTestCase {
    var coordinator: NoteDetailsCoordinator!
    var factory: CoordinatorFactoryMock!
    var router: RouterMock!
    var database: DatabaseProtocol!
    
    override func setUpWithError() throws {
        router = RouterMock()
        database = DatabaseMock()
        factory = CoordinatorFactoryMock()
        
        coordinator = NoteDetailsCoordinator(router: router, folderId: ObjectIdStub(), database: database)
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
    
    func testCoordinatorWasStartedWithNote() {
        let note = NoteStub()
        
        coordinator.start(note)
        
        XCTAssertTrue(router.viewControllerWasPushed)
    }
}
