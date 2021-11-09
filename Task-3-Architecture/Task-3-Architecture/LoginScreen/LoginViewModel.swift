//
//  LoginViewModel.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 18.10.2021.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func viewModelDidValidateCredentials(_ viewModel: LoginViewModel)
}

enum LoginCallbackAction {
    case openMain(UserData)
    case openRegistration
}

enum ValidationError: Error {
    case shortPassword
    case emptyPassword
    case emptyEmail
    case invalidEmail
}

class LoginViewModel {
    private enum Consts {
        static let minPasswordLenth = 8
    }
    
    weak var delegate: LoginViewModelDelegate?
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
    private var callback: (LoginCallbackAction) -> Void
    
    init(email: String? = nil, callback: @escaping (LoginCallbackAction) -> Void) {
        self.email = email
        self.callback = callback
    }
    
    func loginButtonDidTap() {
        guard let email = email, let password = password else { return }
        
        do {
            let result = try LoginManager.shared.login(email: email, password: password)
            callback(.openMain(result))

        } catch {
            callback(.openRegistration)
        }
    }
}
