//
//  AppCoordinator.swift
//  Notes
//
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let router: RouterProtocol
    private let factory: CoordinatorFactoryProtocol
    private let database: DatabaseProtocol
    private let folderListCoordinator: FolderListCoordinatorProtocol
    
    init(factory: CoordinatorFactoryProtocol, router: RouterProtocol, database: DatabaseProtocol) {
        self.router = router
        self.factory = factory
        self.database = database
        self.folderListCoordinator = factory.createFolderListCoordinator(router: router, database: database)
    }
    
    func start() {
        folderListCoordinator.start()
    }
}
