//
//  AccountViewModel.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 07.11.2021.
//

import Foundation

class AccountViewModel {
    let logoutCallback: () -> Void
    let user: UserData
    
    init(user: UserData, callback: @escaping () -> Void) {
        self.user = user
        self.logoutCallback = callback
    }
    
    func logout() {
        LoginManager.shared.logout()
        logoutCallback()
    }
}
