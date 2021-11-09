//
//  LoginViewController.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 18.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    private enum Consts {
        static let emptyPasswordWarning = "Password cannot be empty."
        static let shortPasswordWarning = "Password shoul be minimum of 8 characters."
        static let emptyEmailWarning = "Email cannot be empty."
        static let invalidEmailWarning = "Please enter a valid email adress."
        static let cornerRadius: CGFloat = 5
    }
    
    var viewModel: LoginViewModel? {
        didSet {
            if let email = viewModel?.email {
                emailTextField.text = email
            }
        }
    }

    @IBOutlet private weak var emailWarningLabel: UILabel!
    @IBOutlet private weak var passwordWarningLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        button.layer.cornerRadius = Consts.cornerRadius
    }
    
    @IBAction private func loginButtonDidTap(_ sender: UIButton) {
        viewModel?.loginButtonDidTap()
    }
    
    @IBAction private func emailTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.email = sender.text
    }
    
    @IBAction private func passwordTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.password = sender.text
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func viewModelDidValidateCredentials(_ viewModel: LoginViewModel) {
        handleEmailError(viewModel)
        handlePasswordError(viewModel)
        
        if viewModel.passwordError == nil, viewModel.emailError == nil {
            button.isUserInteractionEnabled = true
            button.backgroundColor = .black
        }
    }
    
    private func handlePasswordError(_ viewModel: LoginViewModel) {
        if let passwordError = viewModel.passwordError {
            switch passwordError {
            case .emptyPassword:
                passwordWarningLabel.isHidden = false
                passwordWarningLabel.text = Consts.emptyPasswordWarning
            case .shortPassword:
                passwordWarningLabel.isHidden = false
                passwordWarningLabel.text = Consts.shortPasswordWarning
            default: return
            }
            
            button.isUserInteractionEnabled = false
            button.backgroundColor = .darkGray
        } else {
            passwordWarningLabel.isHidden = true
        }
    }
    
    private func handleEmailError(_ viewModel: LoginViewModel) {
        if let emailError = viewModel.emailError {
            switch emailError {
            case .emptyEmail:
                emailWarningLabel.isHidden = false
                emailWarningLabel.text = Consts.emptyEmailWarning
            case .invalidEmail:
                emailWarningLabel.isHidden = false
                emailWarningLabel.text = Consts.invalidEmailWarning
            default: return
            }
            
            button.isUserInteractionEnabled = false
            button.backgroundColor = .darkGray
        } else {
            emailWarningLabel.isHidden = true
        }
    }
}

