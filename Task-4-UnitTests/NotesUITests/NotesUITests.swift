//
//  NotesUITests.swift
//  NotesUITests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import XCTest

class NotesUITests: XCTestCase {
    private enum Identifiers {
        static let folderList = "folders_list"
        static let notesList = "notes_list"
        static let noteTextView = "note_text_view"
        static let createFolderButton = "create_folder"
        static let saveFolderButton = "save_folder"
        static let folderNameTextField = "folder_name_textfield"
        static let createNoteButton = "create_note"
    }
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func resetAndLaunch() {
        app.launchArguments = ["--Reset"]
        app.launch()
    }
    
    func launch() {
        app.launch()
    }
    
    func givenAnEmptyFolderList() {
        resetAndLaunch()
    }
    
    func whenCreateFolder(name: String) {
        app.buttons[Identifiers.createFolderButton].tap()
        app.textFields[Identifiers.folderNameTextField].firstMatch.typeText(name)
        app.buttons[Identifiers.saveFolderButton].tap()
    }
    
    func thenFolderExistInList(name: String) {
        XCTAssertTrue(app.tables[Identifiers.folderList].staticTexts[name].exists)
    }

    func testFolderIsCreatedInEmptyList() throws {
        let name = "Example"
        resetAndLaunch()
        givenAnEmptyFolderList()
        whenCreateFolder(name: name)
        
        thenFolderExistInList(name: name)
    }
    
    func folderWasTapped(name: String) {
        app.tables[Identifiers.folderList].staticTexts[name].firstMatch.tap()
    }
    
    func noteListWasOpen() {
        XCTAssertTrue(app.tables[Identifiers.notesList].exists)
    }
    
    func testNotesListWasShownAterTapOnExistingFolder() {
        launch()
        folderWasTapped(name: "Example")
        noteListWasOpen()
    }
    
    func noteDetailsWasShown() {
        app.buttons[Identifiers.createNoteButton].tap()
    }
    
    func someContentIsEntered(content: String) {
        app.textViews[Identifiers.noteTextView].tap()
        app.textViews[Identifiers.noteTextView].firstMatch.typeText(content)
    }
    
    func navigatedBackToFoldersList() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func newNoteIsExistAndShown(name: String) {
        XCTAssertTrue(app.staticTexts[name].exists)
    }
    
    func testNoteIsCreated() {
        let newNoteName = "New note"
        launch()
        folderWasTapped(name: "Example")
        
        noteDetailsWasShown()
        someContentIsEntered(content: newNoteName)
        navigatedBackToFoldersList()
        
        newNoteIsExistAndShown(name: newNoteName)
    }
}
