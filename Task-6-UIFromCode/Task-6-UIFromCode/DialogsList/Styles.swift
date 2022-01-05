//
//  Styles.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import UIKit

struct ConversationCellStyle {
    let avatarComponentCornerRadius: CGFloat = 35
    let readIndicatorCornerRadius: CGFloat = 10
    let stackViewSpacing: CGFloat = 20
    let secondaryTextColor: UIColor = .gray
    let readIndicatorTextColor: UIColor = .white
    let subtitleTextFont: UIFont = .systemFont(ofSize: 14)
    let titleTextFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    let lastMessageLabelNumberOfLines = 2
    let readIndicatorColor: UIColor = .systemBlue
    let avatarComponentStyle = AvatarComponentStyle()
}

struct AvatarComponentStyle {
    let titleFont: UIFont = .systemFont(ofSize: 40)
    let titleTextColor: UIColor = .white
    let avatarBackgroundColor: UIColor = .systemMint
}
