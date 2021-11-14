//
//  DatabaseMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 14.11.2021.
//

import Foundation
@testable import Notes

class DatabaseMock: DatabaseProtocol {
    var persistentContainerWasLoaded = false
    var createdFolderName: String?
    var createdNoteName: String?
    var updatedNoteName: String?
    var deletedFolder: FolderProtocol?
    var deletedNote: NoteProtocol?
    var folders: [FolderProtocol] = []
    var notes: [NoteProtocol] = []
    var sortCondition: SortCondition?
    var folderDataSource: FolderDataSourceMock?
    var noteDataSource: NoteDataSourceMock?
    
    func createFolder(name: String, creationDate: Date, completion: @escaping (Error?) -> Void) {
        createdFolderName = name
    }
    
    func createNote(name: String, body: String, creationDate: Date, folderObjectId: ObjectId) {
        createdNoteName = name
    }
    
    func delete(folder: FolderProtocol) {
        deletedFolder = folder
    }
    
    func delete(note: NoteProtocol) {
        deletedNote = note
    }
    
    func createFolderDataSource(sort: SortCondition) -> FolderDataSourceProtocol {
        sortCondition = sort
        folderDataSource = FolderDataSourceMock(sections: folders, sort: sort)
        
        return folderDataSource!
    }
    
    func createNoteDataSource(sort: SortCondition, folderId: ObjectId) -> NoteDataSourceProtocol {
        sortCondition = sort
        noteDataSource = NoteDataSourceMock(items: notes, sort: sort)
        
        return noteDataSource!
    }
    
    func update(note: NoteProtocol, name: String, body: String) {
        updatedNoteName = name
    }
    
    func open(completion: @escaping () -> Void) {
        persistentContainerWasLoaded = true
    }
}
