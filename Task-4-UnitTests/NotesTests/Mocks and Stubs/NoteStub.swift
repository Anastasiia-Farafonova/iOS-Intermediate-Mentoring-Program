//
//  NoteStub.swift
//  NotesTests
//
//  Created by Anastasiia Farafonova on 22.11.2021.
//

import Foundation
@testable import Notes

class NoteStub: NoteProtocol {
    var body: String?
    var creationDate: Date?
    var name: String?
    var folderObject: FolderProtocol? = FolderStub()
}
