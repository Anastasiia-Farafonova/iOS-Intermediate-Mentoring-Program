//
//  StartViewController.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 11.10.2021.
//

import UIKit

class StartViewController: UIViewController {
    private enum Consts {
        static let cornerRadius: CGFloat = 5
    }
    
    var viewModel: StartViewModel?

    @IBOutlet private var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons.forEach { button in
            button.layer.cornerRadius = Consts.cornerRadius
        }
    }
    
    @IBAction private func loginButtonDidTap(_ sender: UIButton) {
        viewModel?.callback(.openLogin)
    }
    
    @IBAction private func registrationButtonDidTap(_ sender: UIButton) {
        viewModel?.callback(.openRegistration)
    }
}
