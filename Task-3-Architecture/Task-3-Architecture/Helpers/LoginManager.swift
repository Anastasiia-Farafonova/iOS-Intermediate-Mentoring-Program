//
//  LoginManager.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 07.11.2021.
//

import Foundation

class LoginManager {
    private enum Const {
        static let loginKey = "loggedIn"
        static let service = "www.example.com"
    }
    enum LoginManagerError: Error {
        case nonExistentUser
        case existentUser
    }
    
    static let shared = LoginManager()
    static var lastLoggedInUser: String? = {
        return UserDefaults.standard.string(forKey: Const.loginKey)
    }()
    
    private init() { }
    
    func getUserData(email: String) throws -> UserData {
        return try KeychainHelper(service: Const.service, account: email).read()
    }

    func login(email: String, password: String) throws -> UserData {
        let user: UserData = try KeychainHelper(service: Const.service, account: email).read()

        guard user.password == password else {
            throw LoginManagerError.nonExistentUser
        }
        
        UserDefaults.standard.setValue(email, forKey: Const.loginKey)
        
        return user
    }
    
    func register(user: UserData) throws {
        try KeychainHelper(service: Const.service, account: user.email).save(entity: user)
    }
    
    func logout() {
        UserDefaults.standard.setValue(nil, forKey: Const.loginKey)
    }
}
