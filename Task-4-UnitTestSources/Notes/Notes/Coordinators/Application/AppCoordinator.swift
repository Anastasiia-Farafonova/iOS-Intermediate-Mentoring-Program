//
//  AppCoordinator.swift
//  Notes
//
//

import UIKit
import CoreData

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let router: Router
    private lazy var folderListCoordinator = FolderListCoordinator(router: router)
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        folderListCoordinator.start()
    }
    
    func showNote(id: NSManagedObjectID?) {
        folderListCoordinator.showNote(id: id)
    }
}
