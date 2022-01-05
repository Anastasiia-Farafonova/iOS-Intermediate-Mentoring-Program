//
//  AvatarComponentView.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import UIKit

class AvatarComponentView: UIView {
    private lazy var imageView = UIImageView()
    private lazy var nameLabel = UILabel()
    var style: AvatarComponentStyle? {
        didSet {
            setupStyle()
        }
    }
    
    var viewModel: AvatarComponentViewModel? {
        didSet {
            if let imageName = viewModel?.imageName, let image = UIImage(named: imageName) {
                imageView.image = image
            } else {
                nameLabel.text = viewModel?.title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAutolayoutSubview(nameLabel)
        addAutolayoutSubview(imageView)
        
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
    }
    
    private func setupStyle() {
        imageView.contentMode = .scaleAspectFill
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = style?.avatarBackgroundColor
        nameLabel.textColor = style?.titleTextColor
        nameLabel.font = style?.titleFont
    }
    
    private func setupAutolayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
