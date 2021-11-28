//
//  FolderStub.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 14.11.2021.
//

import Foundation
@testable import Notes

class FolderStub: FolderProtocol {
    var creationDate: Date?
    var name: String?
    var notes: NSOrderedSet?
    var contentObjectId: ObjectId = ObjectIdStub()
    var wasDeleted: Bool?
}
