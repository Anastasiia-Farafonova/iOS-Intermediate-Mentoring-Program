//
//  BaseCoordinator.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import Foundation

class BaseCoordinator {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
}
