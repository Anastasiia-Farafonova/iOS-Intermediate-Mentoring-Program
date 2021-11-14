//
//  NoteDataSource.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 22.11.2021.
//

import Foundation
import CoreData

protocol NoteDataSourceDelegate: AnyObject {
    func dataSourceWillChangeContent(_ dataSource: NoteDataSourceProtocol)
    func dataSourceDidChangeContent(_ dataSource: NoteDataSourceProtocol)
    func dataSource(_ dataSource: NoteDataSourceProtocol,
                    didChange note: NoteProtocol,
                    at indexPath: IndexPath?,
                    for type: DataSourceChangeType,
                    newIndexPath: IndexPath?)
}

protocol NoteDataSourceProtocol {
    var delegate: NoteDataSourceDelegate? { get set }
    var sectionsCount: Int { get }
    
    func performFetch()
    func object(at indexPath: IndexPath) -> NoteProtocol
    func numberOfObjectIn(section: Int) -> Int
}

class NoteDataSource: NSObject,NoteDataSourceProtocol, NSFetchedResultsControllerDelegate {
    weak var delegate: NoteDataSourceDelegate?
    var fetchedResultsController: NSFetchedResultsController<Note>
    var sectionsCount: Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    init(fetchedResultsController: NSFetchedResultsController<Note>) {
        self.fetchedResultsController = fetchedResultsController
        super.init()
        self.fetchedResultsController.delegate = self
    }
    
    func performFetch() {
        try? fetchedResultsController.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> NoteProtocol {
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
        guard let note = anObject as? NoteProtocol,
        let type = DataSourceChangeType(rawValue: type.rawValue) else { return }
        
        delegate?.dataSource(self, didChange: note, at: indexPath, for: type, newIndexPath: newIndexPath)
    }
}
