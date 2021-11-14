//
//  FolderDataSource.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 21.11.2021.
//

import Foundation
import CoreData

enum DataSourceChangeType: UInt {
    case insert = 1
    case delete = 2
    case move = 3
    case update = 4
}

protocol FolderDataSourceDelegate: AnyObject {
    func dataSourceWillChangeContent(_ dataSource: FolderDataSourceProtocol)
    func dataSourceDidChangeContent(_ dataSource: FolderDataSourceProtocol)
    func dataSource(_ dataSource: FolderDataSourceProtocol,
                    didChange folder: FolderProtocol,
                    at indexPath: IndexPath?,
                    for type: DataSourceChangeType,
                    newIndexPath: IndexPath?)
}

protocol FolderDataSourceProtocol {
    var delegate: FolderDataSourceDelegate? { get set }
    var sectionsCount: Int { get }
    
    func performFetch()
    func object(at indexPath: IndexPath) -> FolderProtocol?
    func numberOfObjectIn(section: Int) -> Int
    
}

class FolderDataSource: NSObject, FolderDataSourceProtocol, NSFetchedResultsControllerDelegate {
    weak var delegate: FolderDataSourceDelegate?
    var fetchedResultsController: NSFetchedResultsController<Folder>
    var sectionsCount: Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    init(fetchedResultsController: NSFetchedResultsController<Folder>) {
        self.fetchedResultsController = fetchedResultsController
        super.init()
        self.fetchedResultsController.delegate = self
    }
    
    func performFetch() {
        try? fetchedResultsController.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> FolderProtocol? {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func numberOfObjectIn(section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataSourceWillChangeContent(self)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataSourceDidChangeContent(self)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let folder = anObject as? FolderProtocol,
        let type = DataSourceChangeType(rawValue: type.rawValue) else { return }
        
        delegate?.dataSource(self, didChange: folder, at: indexPath, for: type, newIndexPath: newIndexPath)
    }
}
