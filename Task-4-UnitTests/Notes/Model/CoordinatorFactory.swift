//
//  CoordinatorFactory.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 28.11.2021.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func createNoteListCoordinator(router: RouterProtocol, folderId: ObjectId, database: DatabaseProtocol) -> NoteListCoordinatorProtocol
    func createFolderListCoordinator(router: RouterProtocol, database: DatabaseProtocol) -> FolderListCoordinatorProtocol
    func createNoteDetailsCoordinator(router: RouterProtocol, folderId: ObjectId, database: DatabaseProtocol) -> NoteDetailsCoordinatorProtocol
}

class CoordinatorFactory: CoordinatorFactoryProtocol {
    func createNoteDetailsCoordinator(router: RouterProtocol,
                                      folderId: ObjectId,
                                      database: DatabaseProtocol) -> NoteDetailsCoordinatorProtocol {
        return NoteDetailsCoordinator(router: router, folderId: folderId, database: database)
    }
    
    func createFolderListCoordinator(router: RouterProtocol,
                                     database: DatabaseProtocol) -> FolderListCoordinatorProtocol {
        return FolderListCoordinator(factory: self, router: router, database: database)
    }
    
    func createNoteListCoordinator(router: RouterProtocol,
                                   folderId: ObjectId,
                                   database: DatabaseProtocol) -> NoteListCoordinatorProtocol {
        return NoteListCoordinator(router: router, folderId: folderId, database: database, factory: self)
    }
}
