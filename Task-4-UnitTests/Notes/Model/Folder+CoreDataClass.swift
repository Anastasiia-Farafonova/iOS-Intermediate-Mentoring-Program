//
//  Folder+CoreDataClass.swift
//  Notes
//
//
//

import Foundation
import CoreData

enum FolderError: Error {
    case existingFolder
}

enum SortCondition: String {
    case name
    case creationDate
}

public protocol FolderProtocol: AnyObject {
    var creationDate: Date? { get set }
    var name: String? { get set }
    var notes: NSOrderedSet? { get set }
    var contentObjectId: ObjectId { get }
}

@objc(Folder)
public class Folder: NSManagedObject, FolderProtocol {
    public var contentObjectId: ObjectId { objectID }
}
