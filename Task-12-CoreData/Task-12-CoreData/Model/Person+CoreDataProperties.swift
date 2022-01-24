//
//  Person+CoreDataProperties.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//
//

import Foundation
import CoreData

extension Person {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
}

extension Person : Identifiable {

}
