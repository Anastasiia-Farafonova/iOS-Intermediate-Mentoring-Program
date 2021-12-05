//
//  Router.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 05.12.2021.
//

import UIKit

final class Router {
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func setRootController(_ viewController: UIViewController) {
        UIView.transition(with: rootViewController.view,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            self?.rootViewController.setViewControllers([viewController], animated: false)
        })
    }
}
