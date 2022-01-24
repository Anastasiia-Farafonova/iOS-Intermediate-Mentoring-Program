//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Anastasiia Farafonova on 23.01.2022.
//

import UIKit
import UniformTypeIdentifiers

class ShareViewController: UINavigationController {
    private enum Const {
        static let stackViewConstraint: CGFloat = 40
        static let imageTitle = "Image example"
        static let textTitle = "Text example"
        static let urlTitle = "URL example"
        static let font: UIFont = .systemFont(ofSize: 30)
    }
    
    private var viewModel: ShareViewModel?
    private let viewController = UIViewController()
    private lazy var imageView = UIImageView(frame: .zero)
    private lazy var label = UILabel(frame: .zero)
    private lazy var textView = UITextView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ShareViewModel { [weak self] object in
            if let image = object as? UIImage {
                self?.showImage(image)
            } else if let text = object as? String {
                self?.showText(text)
            } else if let url = object as? NSURL, let text = url.absoluteString {
                self?.showUrl(text)
            }
        }
        
        viewModel?.handleExtensionItems(items: extensionContext?.inputItems as? [NSExtensionItem] ?? [])
        setupSubviews()
    }
    
    private func setupSubviews() {
        viewController.view.backgroundColor = .white
        setViewControllers([viewController], animated: false)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                                           style: .plain,
                                                                           target: self,
                                                                           action: #selector(closeAction))
        
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label, textView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: Const.stackViewConstraint),
            stackView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: Const.stackViewConstraint),
            stackView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -Const.stackViewConstraint),
            stackView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -Const.stackViewConstraint)
        ])
    }
    
    @objc private func closeAction() {
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }
    
    private func showImage(_ image: UIImage?) {
        viewController.navigationItem.title = Const.imageTitle
        textView.isHidden = true
        label.isHidden = true
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    private func showText(_ text: String) {
        viewController.navigationItem.title = Const.textTitle
        textView.isHidden = true
        imageView.isHidden = true
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.textColor = .darkGray
        label.font = Const.font
    }
    
    private func showUrl(_ text: String) {
        navigationBar.topItem?.title = Const.urlTitle
        label.isHidden = true
        imageView.isHidden = true
        
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.text = text
        textView.textAlignment = .center
        textView.font = Const.font
    }
}
