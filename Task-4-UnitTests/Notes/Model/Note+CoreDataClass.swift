//
//  Note+CoreDataClass.swift
//  Notes
//
//
//

import Foundation
import CoreData

enum NoteError: Error {
    case existingNote
}

public protocol NoteProtocol: AnyObject {
    var body: String? { get set }
    var creationDate: Date? { get set }
    var name: String? { get set }
    var folderObject: FolderProtocol? { get }
}

@objc(Note)
public class Note: NSManagedObject, NoteProtocol {
    public var folderObject: FolderProtocol? {
        return folder
    }
}
