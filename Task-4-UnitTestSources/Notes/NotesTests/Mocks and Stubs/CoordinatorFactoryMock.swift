//
//  CoordinatorFactoryMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import Foundation
@testable import Notes

class CoordinatorFactoryMock: CoordinatorFactoryProtocol {
    lazy var noteListCoordinator = NoteListCoordinatorMock()
    lazy var folderListCoordinator = FolderListCoordinatorMock()
    lazy var noteDetailsCoordinator = NoteDetailsCoordinatorMock()

    func createNoteListCoordinator(router: RouterProtocol, folderId: ObjectId, database: DatabaseProtocol) -> NoteListCoordinatorProtocol {
        return noteListCoordinator
    }
    
    func createFolderListCoordinator(router: RouterProtocol, database: DatabaseProtocol) -> FolderListCoordinatorProtocol {
        return folderListCoordinator
    }
    
    func createNoteDetailsCoordinator(router: RouterProtocol, folderId: ObjectId, database: DatabaseProtocol) -> NoteDetailsCoordinatorProtocol {
        return noteDetailsCoordinator
    }
}
