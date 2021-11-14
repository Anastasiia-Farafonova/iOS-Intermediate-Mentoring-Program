//
//  NotesViewModel.swift
//  Notes
//
//

import UIKit
import CoreData

class NoteListViewModel {
    private let folderId: ObjectId
    private let coordinator: NoteListCoordinatorProtocol
    private var sort: SortCondition = .creationDate
    private let database: DatabaseProtocol

    var dataSource: NoteDataSourceProtocol

    init(database: DatabaseProtocol, coordinator: NoteListCoordinatorProtocol, folderId: ObjectId) {
        self.database = database
        self.coordinator = coordinator
        self.folderId = folderId
        self.dataSource = database.createNoteDataSource(sort: sort, folderId: folderId)
        self.dataSource.performFetch()
    }

    func addNoteTapped() {
        coordinator.showNoteCreation()
    }
    
    func delete(note: NoteProtocol) {
        database.delete(note: note)
    }
    
    func tappedNote(note: NoteProtocol) {
        coordinator.showNoteDetails(note)
    }
    
    func sort(by sort: SortCondition) {
        guard sort != self.sort else { return }
        self.sort = sort
        
        let delegate = dataSource.delegate
        dataSource = database.createNoteDataSource(sort: sort, folderId: folderId)
        dataSource.delegate = delegate
        
        dataSource.performFetch()
    }
}
