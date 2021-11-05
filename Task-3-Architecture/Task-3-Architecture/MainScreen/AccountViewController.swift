//
//  AccountViewController.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 21.10.2021.
//

import UIKit

class AccountViewController: UIViewController {
    
    private enum Consts {
        static let cornerRadius: CGFloat = 5
        static let imageViewBorderWidth: CGFloat = 5
    }
    
    var viewModel: AccountViewModel? {
        didSet {
            setupSubviews()
        }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    
    @IBAction private func logoutButtonDidTap(_ sender: UIButton) {
        viewModel?.logout()
    }
   
    private func setupSubviews() {
        imageView.layer.borderWidth = Consts.imageViewBorderWidth
        imageView.layer.cornerRadius = Consts.cornerRadius
        logoutButton.layer.cornerRadius = Consts.cornerRadius
        
        firstNameLabel.text = viewModel?.user.firstName
        lastNameLabel.text = viewModel?.user.lastName
        emailLabel.text = viewModel?.user.email
    }
}
