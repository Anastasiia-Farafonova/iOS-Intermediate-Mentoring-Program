//
//  Database.swift
//  Notes
//
//

import Foundation
import CoreData

protocol DatabaseProtocol {
    func createFolder(name: String, creationDate: Date, completion: @escaping (Error?) -> Void)
    func createNote(name: String, body: String, creationDate: Date, folderObjectId: ObjectId)

    func delete(folder: FolderProtocol)
    func open(completion: @escaping () -> Void)
    func delete(note: NoteProtocol)
    func createFolderDataSource(sort: SortCondition) -> FolderDataSourceProtocol
    func createNoteDataSource(sort: SortCondition, folderId: ObjectId) -> NoteDataSourceProtocol
    func update(note: NoteProtocol, name: String, body: String)
}

final class Database: DatabaseProtocol {
    let persistentContainer = NSPersistentContainer(name: "Notes")
    
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    func open(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores(completionHandler: { [weak self] _, error in
            self?.viewContext.automaticallyMergesChangesFromParent = true
            
            DispatchQueue.main.async(execute: completion)
        })
    }
    
    func createFolder(name: String, creationDate: Date, completion: @escaping (Error?) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1
            
            if let result = try? context.fetch(fetchRequest), !result.isEmpty {
                completion(FolderError.existingFolder)
                
                return
            }
            
            let folder = Folder(context: context)
            folder.name = name
            folder.creationDate = creationDate
            
            try? context.save()
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func createNote(name: String, body: String, creationDate: Date, folderObjectId: ObjectId) {
        guard let objectId = folderObjectId as? NSManagedObjectID else { return }
        persistentContainer.performBackgroundTask { context in
            guard let folder = context.object(with: objectId) as? Folder else { return }
            
            let note = Note(context: context)
            note.body = body
            note.name = name
            note.creationDate = creationDate
            note.folder = folder
            
            try? context.save()
        }
    }
    
    
    func delete(folder: FolderProtocol) {
        guard let folder = folder as? Folder else { return }

        persistentContainer.performBackgroundTask { context in
            let folder = context.object(with: folder.objectID)
            context.delete(folder)
            try? context.save()
        }
    }
    
    func createFolderDataSource(sort: SortCondition) -> FolderDataSourceProtocol {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sort.rawValue, ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        
        return FolderDataSource(fetchedResultsController: frc)
    }
    
    func createNoteDataSource(sort: SortCondition, folderId: ObjectId) -> NoteDataSourceProtocol {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sort.rawValue, ascending: true)]
        if let folderId = folderId as? NSManagedObjectID {
            fetchRequest.predicate = NSPredicate(format: "folder == %@", folderId)
        }
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return NoteDataSource(fetchedResultsController: frc)
    }
    
    func delete(note: NoteProtocol) {
        guard let note = note as? Note else { return }
        
        persistentContainer.performBackgroundTask { context in
            let note = context.object(with: note.objectID)
            context.delete(note)
            try? context.save()
        }
    }
    
    func update(note: NoteProtocol, name: String, body: String) {
        guard let note = note as? Note else { return }
        
        persistentContainer.performBackgroundTask { context in
            guard let note = context.object(with: note.objectID) as? Note else { return }
            note.body = body
            note.name = name
            try? context.save()
        }
    }
}
