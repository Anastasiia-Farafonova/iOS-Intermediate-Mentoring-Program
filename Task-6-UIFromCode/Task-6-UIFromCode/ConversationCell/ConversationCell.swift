//
//  DialogCell.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 05.12.2021.
//

import UIKit

class ConversationCell: UITableViewCell {
    private enum Const {
        static let avatarSize = CGSize(width: 70, height: 70)
        static let avatarInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 10)
        static let containerViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
        static let readIndicatorInsets = UIEdgeInsets(top: 5, left: 7, bottom: -5, right: -7)
    }
    
    private lazy var avatarComponent = AvatarComponentView()
    private lazy var dialogNameLabel = UILabel()
    private lazy var lastMessageLabel = UILabel()
    private lazy var lastMessageTimeLabel = UILabel()
    private lazy var readIndicatorView = UIView()
    private lazy var readIndicatorLabel = UILabel()
    
    private lazy var messageNameStackView = UIStackView(arrangedSubviews: [dialogNameLabel, lastMessageLabel])
    private lazy var timeIndiscatorStackView = UIStackView(arrangedSubviews: [lastMessageTimeLabel, readIndicatorView])
    private lazy var containerStackView = UIStackView(arrangedSubviews: [messageNameStackView, timeIndiscatorStackView])
    
    var viewModel: ConversationViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            setup(with: viewModel)
        }
    }
    
    private var style = ConversationCellStyle()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutolayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarComponent.prepareForReuse()
        readIndicatorView.alpha = 1
    }

    private func setup(with viewModel: ConversationViewModel) {
        lastMessageTimeLabel.text = viewModel.lastMessageTime
        readIndicatorLabel.text = viewModel.unreadMessagesText
        lastMessageLabel.text = viewModel.lastMessage
        dialogNameLabel.text = viewModel.dialogName
        avatarComponent.viewModel = AvatarComponentViewModel(imageName: viewModel.avatarImageName, title: viewModel.avatarTitle)
        if viewModel.unreadMessagesQuantity < 1 {
            readIndicatorView.alpha = 0
        }
    }
    
    private func setupStyle() {
        avatarComponent.layer.cornerRadius = style.avatarComponentCornerRadius
        avatarComponent.layer.masksToBounds = true
        avatarComponent.style = style.avatarComponentStyle
        
        containerStackView.spacing = style.stackViewSpacing
        
        lastMessageTimeLabel.textColor = style.secondaryTextColor
        lastMessageTimeLabel.font = style.subtitleTextFont
        
        readIndicatorView.backgroundColor = style.readIndicatorColor
        readIndicatorLabel.textColor = style.readIndicatorTextColor
        readIndicatorView.layer.cornerRadius = style.readIndicatorCornerRadius
        readIndicatorLabel.layer.masksToBounds = true
        readIndicatorLabel.font = style.subtitleTextFont
        
        lastMessageLabel.numberOfLines = style.lastMessageLabelNumberOfLines
        lastMessageLabel.font = style.subtitleTextFont
        lastMessageLabel.textColor = style.secondaryTextColor
        
        dialogNameLabel.font = style.titleTextFont
    }
    
    private func setupAutolayout() {
        contentView.addSubviewAndDisableAutoresizingMask(avatarComponent)
        contentView.addSubviewAndDisableAutoresizingMask(containerStackView)
        readIndicatorView.addSubviewAndDisableAutoresizingMask(readIndicatorLabel)

        messageNameStackView.axis = .vertical
        messageNameStackView.distribution = .fillProportionally
        messageNameStackView.alignment = .leading
        
        timeIndiscatorStackView.axis = .vertical
        timeIndiscatorStackView.alignment = .trailing
        timeIndiscatorStackView.distribution = .equalCentering
        
        containerStackView.distribution = .fillProportionally
        lastMessageTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        readIndicatorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            avatarComponent.widthAnchor.constraint(equalToConstant: Const.avatarSize.width),
            avatarComponent.heightAnchor.constraint(equalToConstant: Const.avatarSize.height),
            avatarComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.avatarInsets.left),
            avatarComponent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarComponent.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Const.avatarInsets.top),
            avatarComponent.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Const.avatarInsets.bottom),
                        
            containerStackView.leadingAnchor.constraint(equalTo: avatarComponent.trailingAnchor, constant: Const.containerViewInsets.left),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Const.containerViewInsets.right),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.containerViewInsets.top),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Const.containerViewInsets.bottom),
            readIndicatorLabel.trailingAnchor.constraint(equalTo: readIndicatorView.trailingAnchor, constant: Const.readIndicatorInsets.right),
            readIndicatorLabel.leadingAnchor.constraint(equalTo: readIndicatorView.leadingAnchor, constant: Const.readIndicatorInsets.left),
            readIndicatorLabel.topAnchor.constraint(equalTo: readIndicatorView.topAnchor, constant: Const.readIndicatorInsets.top),
            readIndicatorLabel.bottomAnchor.constraint(equalTo: readIndicatorView.bottomAnchor, constant: Const.readIndicatorInsets.bottom)
        ])
    }
}
