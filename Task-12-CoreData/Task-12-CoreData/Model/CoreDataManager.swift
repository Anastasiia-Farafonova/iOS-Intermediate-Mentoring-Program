//
//  CoreDataManager.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Task_12_CoreData")
        container.loadPersistentStores { _, _ in }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext { storeContainer.viewContext }
    
    func saveContext () {
        guard viewContext.hasChanges else { return }
        try? viewContext.save()
    }
    
    func getFetchResultsController() -> NSFetchedResultsController<Person> {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Person.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: viewContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        
        try? fetchedResultsController.performFetch()
        
        return fetchedResultsController
    }
    
    func delete(person: Person) {
        viewContext.delete(person)
        saveContext()
    }
    
    func savePerson(name: String?, phone: String?, email: String?, address: String?) -> Person {
        let person = Person(context: viewContext)
        let id = UUID()
        person.id = id
        person.name = name
        person.phone = phone
        person.email = email
        person.address = address
        saveContext()
        
        return person
    }
}
