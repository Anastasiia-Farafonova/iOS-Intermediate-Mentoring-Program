//
//  NoteListViewModelTest.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 21.11.2021.
//

import XCTest
@testable import Notes

class NoteListViewModelTest: XCTestCase {
    var viewModel: NoteListViewModel!
    var coordinator: NoteListCoordinatorMock!
    var database: DatabaseMock!
    var delegate: NoteDataSourceDelegateMock!
    
    override func setUpWithError() throws {
        coordinator = NoteListCoordinatorMock()
        database = DatabaseMock()
        viewModel = NoteListViewModel(database: database, coordinator: coordinator, folderId: ObjectIdStub())
    }

    override func tearDownWithError() throws {
        coordinator = nil
        viewModel = nil
        database = nil
    }
    
    func testNoteCreationWasShow() {
        viewModel.addNoteTapped()
        
        XCTAssertTrue(coordinator.noteCreationShown)
    }
    
    func testNoteDetailsWasShown() {
        let note = NoteStub()
        
        viewModel.tappedNote(note: note)
        
        XCTAssertIdentical(note, coordinator.receivedNote)
    }
    
    func testDeleteNote() {
        let note = NoteStub()

        viewModel.delete(note: note)
        
        XCTAssertIdentical(note, database.deletedNote)
    }
    
    func testSort() {
        let sortCondition: SortCondition = .name
        
        viewModel.sort(by: sortCondition)
        
        XCTAssertIdentical(viewModel.dataSource.delegate, delegate)
        XCTAssertEqual(database.sortCondition, sortCondition)
        XCTAssertTrue(database.noteDataSource!.performFetchCalled)
    }
    
    func testNothingHappensWhenCurrentSortExists() {
        let sortCondition: SortCondition = .creationDate
        database.sortCondition = nil
        
        viewModel.sort(by: sortCondition)
        
        XCTAssertNil(database.sortCondition)
    }
}
