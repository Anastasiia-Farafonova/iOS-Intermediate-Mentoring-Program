//
//  ObjectId.swift
//  Notes
//
//  Created by Anastasiia Farafonova on 14.11.2021.
//

import Foundation
import CoreData

public protocol ObjectId: AnyObject {
    
}

extension NSManagedObjectID: ObjectId {
    
}
