//
//  AppCoordinator.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 05.12.2021.
//

import UIKit

class AppCoordinator {
    private let router: Router
    private let viewController = DialogsListViewController()
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let model = DialogsModel()
        viewController.viewModel = DialogListViewModel(model: model)
        self.router.setRootController(viewController)
    }
}
