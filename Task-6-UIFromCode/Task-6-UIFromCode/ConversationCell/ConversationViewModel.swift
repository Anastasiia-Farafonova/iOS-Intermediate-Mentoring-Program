//
//  ConversationViewModel.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import Foundation

class ConversationViewModel {
    private enum Const {
        static let numberOfAvatarLetters = 2
        static let minNumberOfGroupMembers = 2
    }
    
    let dialogName: String
    let lastMessage: String
    let lastMessageTime: String
    let unreadMessagesQuantity: Int
    let avatarTitle: String
    var unreadMessagesText: String?
    var avatarImageName: String?
    
    init(conversation: Conversation) {
        self.dialogName = conversation.name
        self.lastMessage = conversation.lastMessage.text
        self.lastMessageTime = conversation.lastMessage.time
        self.unreadMessagesQuantity = conversation.unreadMessagesQuantity
        self.avatarTitle = String(dialogName.prefix(Const.numberOfAvatarLetters))

        if conversation.unreadMessagesQuantity > 0 {
            self.unreadMessagesText = String(conversation.unreadMessagesQuantity)
        }
        
        if conversation.members < Const.minNumberOfGroupMembers {
            self.avatarImageName = conversation.avatar
        }
    }
}
