//
//  NotesCoordinator.swift
//  Notes
//
//

import UIKit
import CoreData

protocol NoteListCoordinatorProtocol: Coordinator {
    func showNoteCreation()
    func showNoteDetails(_ note: NoteProtocol)
}

class NoteListCoordinator: NoteListCoordinatorProtocol {
    private let router: RouterProtocol
    private let folderId: ObjectId
    private let database: DatabaseProtocol
    private let factory: CoordinatorFactoryProtocol
    
    init(router: RouterProtocol,
         folderId: ObjectId,
         database: DatabaseProtocol,
         factory: CoordinatorFactoryProtocol) {
        self.router = router
        self.folderId = folderId
        self.database = database
        self.factory = factory
    }
    
    func start() {
        let notesController: NoteListViewController = NoteListViewController.instantiate()
        notesController.viewModel = NoteListViewModel(database: database, coordinator: self, folderId: folderId)
        router.push(notesController)
    }
    
    func showNoteCreation() {
        factory.createNoteDetailsCoordinator(router: router, folderId: folderId, database: database).start()
    }
    
    func showNoteDetails(_ note: NoteProtocol) {
        factory.createNoteDetailsCoordinator(router: router, folderId: folderId, database: database).start(note)
    }
}
