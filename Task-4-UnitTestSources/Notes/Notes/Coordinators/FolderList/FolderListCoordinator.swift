//
//  FoldersCoordintor.swift
//  Notes
//
//

import UIKit
import CoreData

class FolderListCoordinator: Coordinator {
    private let router: Router
    private var ncDelecate: NotificationCenterDelegate?
    private let queue = OperationQueue()
    
    init(router: Router) {
        self.router = router
        self.queue.isSuspended = true
    }
    
    func start() {
        Database.shared.open { [weak self] in
            guard let self = self else { return }
            
            let folderController: FolderListViewController = FolderListViewController.instantiate()
            folderController.viewModel = FolderListViewModel(coordinator: self)
            
            self.router.setRootController(folderController)
            self.ncDelecate = NotificationCenterDelegate(router: self.router)
            
            UNUserNotificationCenter.current().delegate = self.ncDelecate
            self.queue.isSuspended = false
        }
    }
    
    func showNotesList(folderId: NSManagedObjectID) {
        NoteListCoordinator(router: router, folderId: folderId).start()
    }
    
    func showNote(id: NSManagedObjectID?) {
        queue.addOperation { [weak self] in
            guard let self = self else { return }
            
            OperationQueue.main.addOperation {
                if let id = id, let note = Database.shared.viewContext.object(with: id) as? Note  {
                    self.openExistNote(note)
                } else {
                    self.openNewNote()
                }
            }
        }
    }
    
    private func openExistNote(_ note: Note) {
        guard let folderId = note.folder?.objectID else { return }
        NoteDetailsCoordinator(router: router, folderId: folderId).start(note)
    }
    
    private func openNewNote() {
        Folder.create(name: "New folder \(Date())", creationDate: Date()) { [weak self] folderId, _ in
            guard let self = self, let folderId = folderId else { return }
            NoteDetailsCoordinator(router: self.router, folderId: folderId).start()
        }
    }
}
