//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Anastasiia Farafonova on 23.01.2022.
//

import UIKit
import UniformTypeIdentifiers

class ShareViewController: UINavigationController {
    private let viewController = UIViewController()
    let imageView = UIImageView(frame: .zero)
    let label = UILabel(frame: .zero)
    let textView = UITextView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.view.backgroundColor = .white
        setViewControllers([viewController], animated: false)
        setupSubviews()

        handleExtensionItems(items: extensionContext?.inputItems as? [NSExtensionItem] ?? [])
    }
    
    private func setupSubviews() {
        let stackView = UIStackView(arrangedSubviews: [imageView, label, textView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -20),
        ])
    }
    
    private func handleExtensionItems(items: [NSExtensionItem]) {
        items.forEach { item in
            item.attachments?.forEach { provider in
                let types = provider.registeredTypeIdentifiers.map { UTType($0) }
                types.forEach { type in
                    guard let type = type else { return }
                    
                    if type.conforms(to: .image) {
                        provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) { [weak self] data, error in
                            self?.handleSharedImage(data: data)
                        }
                    } else if type.conforms(to: .url) {
                        provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { [weak self] data, error in
                            self?.handleSharedUrl(data: data)
                        }
                    } else if type.conforms(to: .text) {
                        provider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { [weak self] data, error in
                            self?.handleSharedText(data: data)
                        }
                    }
                }
            }
        }
    }
    
    private func handleSharedImage(data: NSSecureCoding?) {
        var image: UIImage?
        
        if let item = data as? UIImage {
            image = item
        } else if let item = data as? URL, let data = try? Data(contentsOf: item) {
            image = UIImage(data: data)
        } else if let item = data as? Data {
            image = UIImage(data: item)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.showImage(image)
        }
    }
    
    private func handleSharedUrl(data: NSSecureCoding?) {
        if let url = data as? NSURL, let text = url.absoluteString {
            DispatchQueue.main.async { [weak self] in
                self?.showUrl(text)
            }
        }
    }
    
    private func handleSharedText(data: NSSecureCoding?) {
        if let text = data as? NSString {
            DispatchQueue.main.async { [weak self] in
                self?.showText(text as String)
            }
        }
    }
    
    private func showImage(_ image: UIImage?) {
        viewController.navigationItem.title = "Image example"
        textView.isHidden = true
        label.isHidden = true
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
    }
    
    private func showText(_ text: String) {
        viewController.navigationItem.title = "Text example"
        textView.isHidden = true
        imageView.isHidden = true
        
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 30)

    }
    
    private func showUrl(_ text: String) {
        navigationBar.topItem?.title = "URL example"
        label.isHidden = true
        imageView.isHidden = true
        
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.text = text
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 30)
    }
}
