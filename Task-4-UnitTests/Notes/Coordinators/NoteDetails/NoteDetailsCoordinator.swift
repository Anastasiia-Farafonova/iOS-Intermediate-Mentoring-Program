//
//  NoteCoordinator.swift
//  Notes
//
//

import UIKit
import CoreData

protocol NoteDetailsCoordinatorProtocol: Coordinator {
    func start(_ note: NoteProtocol)
}

class NoteDetailsCoordinator: NoteDetailsCoordinatorProtocol {
    private let router: RouterProtocol
    private let folderId: ObjectId
    private let database: DatabaseProtocol
    
    init(router: RouterProtocol,
         folderId: ObjectId,
         database: DatabaseProtocol) {
        self.router = router
        self.folderId = folderId
        self.database = database
    }
    
    func start() {
        let noteController: NoteDetailsViewController = NoteDetailsViewController.instantiate()
        noteController.viewModel = NoteDetailsViewModel(folderId: folderId, database: database)
        router.push(noteController)
    }
    
    func start(_ note: NoteProtocol) {
        let noteController: NoteDetailsViewController = NoteDetailsViewController.instantiate()
        noteController.viewModel = NoteDetailsViewModel(folderId: folderId, database: database)
        noteController.viewModel.note = note
        router.push(noteController)
    }
}
