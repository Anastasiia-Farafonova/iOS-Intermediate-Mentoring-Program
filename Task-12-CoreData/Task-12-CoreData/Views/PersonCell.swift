//
//  PersonCell.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        addressLabel.text = nil
        numberLabel.text = nil
        emailLabel.text = nil
        nameLabel.text = nil
        avatarView.image = nil
    }
    
    func setup(name: String?, email: String?, phone: String?, address: String?, image: UIImage?) {
        nameLabel.text = name
        emailLabel.text = email
        numberLabel.text = phone
        addressLabel.text = address
        avatarView.image = image
    }
}
