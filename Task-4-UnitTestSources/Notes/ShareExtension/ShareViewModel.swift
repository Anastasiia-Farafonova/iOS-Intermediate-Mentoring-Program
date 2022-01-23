//
//  ShareViewModel.swift
//  ShareExtension
//
//  Created by Anastasiia Farafonova on 24.01.2022.
//

import UIKit
import UniformTypeIdentifiers

class ShareViewModel {
    var callback: (Any) -> Void
    
    init(callback: @escaping (Any) -> Void) {
        self.callback = callback
    }
    
    func handleExtensionItems(items: [NSExtensionItem]) {
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
            self?.callback(image as Any)
        }
    }
    
    private func handleSharedUrl(data: NSSecureCoding?) {
        if let url = data as? NSURL {
            DispatchQueue.main.async { [weak self] in
                self?.callback(url as Any)
            }
        }
    }
    
    private func handleSharedText(data: NSSecureCoding?) {
        if let text = data as? NSString {
            DispatchQueue.main.async { [weak self] in
                self?.callback(text as Any)
            }
        }
    }
}
