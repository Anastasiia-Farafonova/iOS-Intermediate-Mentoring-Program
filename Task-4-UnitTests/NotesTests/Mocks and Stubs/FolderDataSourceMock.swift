//
//  FolderDataSourceMock.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 21.11.2021.
//

import Foundation
@testable import Notes

class FolderDataSourceDelegateMock: FolderDataSourceDelegate {
    func dataSourceWillChangeContent(_ dataSource: FolderDataSourceProtocol) {
        
    }
    
    func dataSourceDidChangeContent(_ dataSource: FolderDataSourceProtocol) {
        
    }
    
    func dataSource(_ dataSource: FolderDataSourceProtocol, didChange folder: FolderProtocol, at indexPath: IndexPath?, for type: DataSourceChangeType, newIndexPath: IndexPath?) {
    }
}

class FolderDataSourceMock: FolderDataSourceProtocol {
    var delegate: FolderDataSourceDelegate?
    var performFetchCalled: Bool = false
    
    var sectionsCount: Int {
        items.count
    }
    
    let items: [FolderProtocol]
    
    init(sections: [FolderProtocol], sort: SortCondition) {
        if sort == .creationDate {
            self.items = sections.sorted { $0.creationDate! > $1.creationDate! }
        } else if sort == .name {
            self.items = sections.sorted { $0.name! > $1.name! }
        } else {
            self.items = []
        }
    }
    
    func performFetch() {
        performFetchCalled = true
    }
    
    func object(at indexPath: IndexPath) -> FolderProtocol? {
        items[indexPath.row]
    }
    
    func numberOfObjectIn(section: Int) -> Int {
        return items.count
    }
}
