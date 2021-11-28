//
//  NoteDataSourceDelegateMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 22.11.2021.
//

import Foundation
@testable import Notes

class NoteDataSourceDelegateMock: NoteDataSourceDelegate {
    func dataSourceWillChangeContent(_ dataSource: NoteDataSourceProtocol) {
        
    }
    
    func dataSourceDidChangeContent(_ dataSource: NoteDataSourceProtocol) {
        
    }
    
    func dataSource(_ dataSource: NoteDataSourceProtocol, didChange note: NoteProtocol, at indexPath: IndexPath?, for type: DataSourceChangeType, newIndexPath: IndexPath?) {
        
    }
}


class NoteDataSourceMock: NoteDataSourceProtocol {
    var delegate: NoteDataSourceDelegate?
    var performFetchCalled: Bool = false
    
    var sectionsCount: Int {
        items.count
    }
    
    let items: [NoteProtocol]
    
    init(items: [NoteProtocol], sort: SortCondition) {
        if sort == .creationDate {
            self.items = items.sorted { $0.creationDate! > $1.creationDate! }
        } else if sort == .name {
            self.items = items.sorted { $0.name! > $1.name! }
        } else {
            self.items = []
        }
    }
    
    func performFetch() {
        performFetchCalled = true
    }
    
    func object(at indexPath: IndexPath) -> NoteProtocol {
        items[indexPath.row]
    }
    
    
    func numberOfObjectIn(section: Int) -> Int {
        return items.count
    }
}
