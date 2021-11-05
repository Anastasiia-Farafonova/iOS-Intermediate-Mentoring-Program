//
//  RegistrationScreen.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 17.10.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    private enum Consts {
        static let emptyPasswordWarning = "Password cannot be empty."
        static let shortPasswordWarning = "Password shoul be minimum of 8 characters."
        static let emptyEmailWarning = "Email cannot be empty."
        static let invalidEmailWarning = "Please enter a valid email adress."
        static let cornerRadius: CGFloat = 5
        static let enabledButtonBackground: UIColor = .black
        static let disenabledButtonBackground: UIColor = .darkGray
    }
    
    var viewModel: RegistrationViewModel?
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var emailWarningLabel: UILabel!
    @IBOutlet private weak var passwordWarningLabel: UILabel!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    @IBAction private func registrationButtonDidTap(_ sender: UIButton) {
        viewModel?.register(firstName: firstNameTextField.text,
                            lastName: lastNameTextField.text,
                            email: emailTextField.text,
                            password: passwordTextField.text)
    }
    
    @IBAction private func passwordTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.password = sender.text
    }
    
    @IBAction private  func emailTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.email = sender.text
    }
    
    private func setupSubviews() {
        button.layer.cornerRadius = Consts.cornerRadius
        button.isUserInteractionEnabled = false
        button.backgroundColor = Consts.disenabledButtonBackground
    }
}

extension RegistrationViewController: RegistrationViewModelDelegate {
    func viewModelDidValidateCredentials(_ viewModel: RegistrationViewModel) {
        handleEmailError(viewModel)
        handlePasswordError(viewModel)
        
        if viewModel.passwordError == nil, viewModel.emailError == nil {
            button.isUserInteractionEnabled = true
            button.backgroundColor = Consts.enabledButtonBackground
        }
    }
    
    private func handlePasswordError(_ viewModel: RegistrationViewModel) {
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
            button.backgroundColor = Consts.disenabledButtonBackground
        } else {
            passwordWarningLabel.isHidden = true
        }
    }
    
    private func handleEmailError(_ viewModel: RegistrationViewModel) {
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
            button.backgroundColor = Consts.disenabledButtonBackground
        } else {
            emailWarningLabel.isHidden = true
        }
    }
}
