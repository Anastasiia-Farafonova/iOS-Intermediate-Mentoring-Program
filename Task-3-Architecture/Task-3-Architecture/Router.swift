//
//  Router.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import UIKit

final class Router {
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func pushViewController(_ viewController: UIViewController) {
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        UIView.transition(with: rootViewController.view,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.rootViewController.setViewControllers([viewController], animated: false)
                          })
    }
}
