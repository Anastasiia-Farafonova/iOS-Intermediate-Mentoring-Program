//
//  AccountViewModel.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import Foundation

public enum ActionType {
    case openLogin
    case openRegistration
}

class StartViewModel {
    let coordinator: BaseCoordinator
    let callback: ((ActionType) -> Void)
    
    init(coordinator: BaseCoordinator, callback: @escaping ((ActionType) -> Void)) {
        self.coordinator = coordinator
        self.callback = callback
    }
}
