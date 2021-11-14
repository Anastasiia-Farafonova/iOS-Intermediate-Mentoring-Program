//
//  FolderViewModel.swift
//  Notes
//
//

import UIKit

class FolderListViewModel {
    private let coordinator: FolderListCoordinatorProtocol
    private var sort: SortCondition = .creationDate
    private let database: DatabaseProtocol
    
    var dataSource: FolderDataSourceProtocol
    
    internal init(coordinator: FolderListCoordinatorProtocol,
                  database: DatabaseProtocol) {
        self.database = database
        self.coordinator = coordinator
        self.dataSource = database.createFolderDataSource(sort: sort)
        self.dataSource.performFetch()
    }

    func createFolder(name: String) {
        guard !name.isEmpty else { return }

        database.createFolder(name: name, creationDate: Date(), completion: { _ in })
    }
    
    func delete(folder: FolderProtocol) {
        database.delete(folder: folder)
    }

    func showNotesList(folder: FolderProtocol) {
        coordinator.showNotesList(folderId: folder.contentObjectId)
    }
    
    func sort(by sort: SortCondition) {
        guard sort != self.sort else { return }
        self.sort = sort
        
        let delegate = dataSource.delegate
        
        dataSource = database.createFolderDataSource(sort: sort)
        dataSource.delegate = delegate
        
        dataSource.performFetch()
    }
}

