//
//  FoldersCoordintor.swift
//  Notes
//
//

import UIKit

protocol FolderListCoordinatorProtocol: Coordinator {
    func showNotesList(folderId: ObjectId)
}

class FolderListCoordinator: FolderListCoordinatorProtocol {
    private let router: RouterProtocol
    private let factory: CoordinatorFactoryProtocol
    private let database: DatabaseProtocol
    private var noteListCoordinator: NoteListCoordinatorProtocol?
    
    init(factory: CoordinatorFactoryProtocol, router: RouterProtocol, database: DatabaseProtocol) {
        self.router = router
        self.factory = factory
        self.database = database
    }
    
    func start() {
        database.open { [weak self] in
            guard let self = self else { return }

            let folderController: FolderListViewController = FolderListViewController.instantiate()
            folderController.viewModel = FolderListViewModel(coordinator: self, database: self.database)
            
            self.router.setRootController(folderController)
        }
    }
    
    func showNotesList(folderId: ObjectId) {
        noteListCoordinator = factory.createNoteListCoordinator(router: router,
                                                                folderId: folderId,
                                                                database: database)
        noteListCoordinator?.start()
    }
}
