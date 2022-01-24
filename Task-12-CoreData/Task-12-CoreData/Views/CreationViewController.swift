//
//  CreationViewController.swift
//  Task-12-CoreData
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import Foundation
import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    private var imagePicker =  UIImagePickerController()
    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction private func addImageAction(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction private func saveAction(_ sender: UIButton) {
        viewModel?.savePerson(name: nameTextField.text,
                             phone: phoneTextField.text,
                             email: emailTextField.text,
                             address: addressTextField.text,
                             imagePng: avatarView.image?.pngData())
        
        navigationController?.popViewController(animated: true)
    }
}

extension CreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarView.image = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
