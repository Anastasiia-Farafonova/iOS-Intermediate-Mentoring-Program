//
//  NoteDetailsViewModelTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 22.11.2021.
//

import XCTest
@testable import Notes

class NoteDetailsViewModelTest: XCTestCase {
    var viewModel: NoteDetailsViewModel!
    var database: DatabaseMock!
    
    override func setUpWithError() throws {
        database = DatabaseMock()
        viewModel = NoteDetailsViewModel(folderId: ObjectIdStub(), database: database)
    }
    
    override func tearDownWithError() throws {
        database = nil
        viewModel = nil
    }
    
    func testNoteWasUpdatedIfItExist() {
        let note = NoteStub()
        let body = "new body"
        viewModel.note = note
        
        viewModel.update(body: body)
        
        XCTAssertEqual(body, database.updatedNoteName)
    }
    
    func testNoteWasCreatedIfItDoesNotExist() {
        let body = "new body"

        viewModel.update(body: body)
        
        XCTAssertEqual(body, database.createdNoteName)
    }
    
    func testNothingHeppensWhenBodyIsEmpty() {
        let body = ""
        
        viewModel.update(body: body)
        
        XCTAssertNil(database.createdNoteName)
        XCTAssertNil(database.updatedNoteName)
    }
}
