//
//  NoteDetailsViewModel.swift
//  Notes
//
//

import Foundation
import CoreData

class NoteDetailsViewModel {
    private let folderId: ObjectId
    private lazy var creationDate: Date = { note?.creationDate ?? Date() }()
    
    var note: NoteProtocol?
    var creationDateTitle: String { creationDate.shortDate() }
    var body: String? { note?.body }
    private let database: DatabaseProtocol
    
    init(folderId: ObjectId, database: DatabaseProtocol) {
        self.folderId = folderId
        self.database = database
    }
    
    func update(body: String) {
        guard !body.isEmpty else {
            return
        }
        
        let name = String(body.prefix(20))
        
        if let note = note {
            database.update(note: note, name: name, body: body)
        } else {
            database.createNote(name: name, body: body, creationDate: creationDate, folderObjectId: folderId)
        }
    }
}
