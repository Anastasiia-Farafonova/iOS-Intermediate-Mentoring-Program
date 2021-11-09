//
//  ApplicationCoordinator.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    func start() {
        if let email = LoginManager.lastLoggedInUser {
            do {
                let user = try LoginManager.shared.getUserData(email: email)
                startMain(user: user)
            } catch  {
                startHome()
            }
        } else {
            startHome()
        }
    }
    
    private func startHome() {
        let viewModel = StartViewModel(coordinator: self) { [weak self] action in
            switch action {
            case .openLogin:
                self?.startLogin()
            case .openRegistration:
                self?.startRegistration()
            }
        }
        
        let viewController = StartViewController.loadFromNib() as? StartViewController
        viewController?.viewModel = viewModel
        router.setRootViewController(viewController ?? UIViewController())
    }
    
    private func startLogin(email: String? = nil) {
        let viewModel = LoginViewModel(email: email) { [weak self] action in
            switch action {
            case .openMain(let user):
                self?.startMain(user: user)
            case .openRegistration:
                self?.startRegistration()
            }
        }
        let viewController = LoginViewController.loadFromNib() as? LoginViewController
        viewController?.viewModel = viewModel
        viewModel.delegate = viewController
        router.pushViewController(viewController ?? UIViewController())
    }
    
    private func startRegistration() {
        let viewModel = RegistrationViewModel { [weak self] action in
            switch action {
            case .openLogin(let email):
                self?.startLogin(email: email)
            case .openMain(let user):
                self?.startMain(user: user)
            }
        }
        let viewController = RegistrationViewController.loadFromNib() as? RegistrationViewController
        viewController?.viewModel = viewModel
        viewModel.delegate = viewController
        router.pushViewController(viewController ?? UIViewController())
    }
    
    private func startMain(user: UserData) {
        let viewModel = AccountViewModel(user: user) { [weak self] in
            self?.startHome()
        }
        let viewController = AccountViewController.loadFromNib() as? AccountViewController
        viewController?.viewModel = viewModel
        router.setRootViewController(viewController ?? UIViewController())
    }
}
