//
//  NotesTests.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 14.11.2021.
//

import XCTest
@testable import Notes

class FolderListViewModelTests: XCTestCase {
    var viewModel: FolderListViewModel!
    var database: DatabaseMock!
    var coordinator: FolderListCoordinatorMock!
    var delegate: FolderDataSourceDelegateMock!
    
    override func setUpWithError() throws {
        coordinator = FolderListCoordinatorMock()
        database = DatabaseMock()
        viewModel = FolderListViewModel(coordinator: coordinator, database: database)
        delegate = .init()
        viewModel.dataSource.delegate = delegate
    }

    override func tearDownWithError() throws {
        coordinator = nil
        viewModel = nil
        database = nil
        delegate = nil
    }

    func testFolderIsCreatedWhenNameHasCharacters() throws {
        let folderName = "New folder"
        
        viewModel.createFolder(name: folderName)
        
        XCTAssertEqual(folderName, database.createdFolderName)
    }
    
    func testFolderIsNotCreatedWhenNameIsEmpty() throws {
        let folderName = ""
        
        viewModel.createFolder(name: folderName)
        
        XCTAssertNil(database.createdFolderName)
    }
    
    func testNotesListWasDisplayed() {
        let folder = FolderStub()
        
        viewModel.showNotesList(folder: folder)
        
        XCTAssertIdentical(folder.contentObjectId, coordinator.receivedFolderId)
    }
    
    func testDeleteFolder() {
        let folder = FolderStub()
        
        viewModel.delete(folder: folder)
        
        XCTAssertIdentical(folder, database.deletedFolder)
    }
    
    func testSort() {
        let sortCondition: SortCondition = .name
        
        viewModel.sort(by: sortCondition)
        
        XCTAssertIdentical(viewModel.dataSource.delegate, delegate)
        XCTAssertEqual(database.sortCondition, sortCondition)
        XCTAssertTrue(database.folderDataSource!.performFetchCalled)
    }
    
    func testNothingHappensWhenCurrentSortExists() {
        let sortCondition: SortCondition = .creationDate
        // We need to nil sortCondition in database because
        // folderDataSource was created during initialization
        database.sortCondition = nil
        
        viewModel.sort(by: sortCondition)
        
        XCTAssertNil(database.sortCondition)
    }
}
