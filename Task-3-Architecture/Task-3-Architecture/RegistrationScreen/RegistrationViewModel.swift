//
//  RegistrationViewModel.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import Foundation

protocol RegistrationViewModelDelegate: AnyObject {
    func viewModelDidValidateCredentials(_ viewModel: RegistrationViewModel)
}

enum RegistratioCallbackAction {
    case openLogin(email: String)
    case openMain(UserData)
}

class RegistrationViewModel {
    private enum Consts {
        static let minPasswordLenth = 8
    }
    
    weak var delegate: RegistrationViewModelDelegate?
    var passwordError: ValidationError? = .emptyPassword
    var emailError: ValidationError? = .emptyEmail
    
    var email: String? {
        didSet {
            if let email = email, email.isEmpty {
                emailError = .emptyEmail
            } else if let email = email, !email.contains("@") {
                emailError = .invalidEmail
            } else {
                emailError = nil
            }
            
            delegate?.viewModelDidValidateCredentials(self)
        }
    }
    
    var password: String? {
        didSet {
            if let password = password, password.isEmpty {
                passwordError = .emptyPassword
            } else if let password = password, password.count < Consts.minPasswordLenth {
                passwordError = .shortPassword
            } else {
                passwordError = nil
            }
            
            delegate?.viewModelDidValidateCredentials(self)
        }
    }
    
    private var callback: (RegistratioCallbackAction) -> Void
    
    init(callback: @escaping (RegistratioCallbackAction) -> Void) {
        self.callback = callback
    }
    
    func register(firstName: String?, lastName: String?, email: String?, password: String?) {
        guard emailError == nil,
              passwordError == nil,
              let email = email,
              let password = password,
              let firstName = firstName,
              let lastName = lastName else { return }
        
        do {
            let user = UserData(firstName: firstName, lastName: lastName, password: password, email: email)
            
            try LoginManager.shared.register(user: user)
            callback(.openMain(user))
        } catch {
            callback(.openLogin(email: email))
        }
    }
}
