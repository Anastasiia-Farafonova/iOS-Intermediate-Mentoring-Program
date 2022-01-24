//
//  ViewModel.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import Foundation
import CoreData

class ViewModel {
    private let database = CoreDataManager()
    
    func getFetchResultsController() -> NSFetchedResultsController<Person> {
        database.getFetchResultsController()
    }
    
    func delete(person: Person) {
        database.delete(person: person)
    }
    
    func savePerson(name: String?, phone: String?, email: String?, address: String?, imagePng: Data?) {
        let person = database.savePerson(name: name, phone: phone, email: email, address: address)
        if let imagePng = imagePng, let path = person.photoUrl {
            try? imagePng.write(to: path)
        }
    }
}
