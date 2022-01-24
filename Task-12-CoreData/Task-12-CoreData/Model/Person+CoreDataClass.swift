//
//  Person+CoreDataClass.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    var photoUrl: URL? {
        if let id = id {
            return FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(id.uuidString)
                .appendingPathExtension("png")
        }
        
        return nil
    }
}
