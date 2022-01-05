//
//  DialogData.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import Foundation

struct Message {
    let text: String
    let time: String
}

struct Conversation {
    let avatar: String?
    let members: Int
    let name: String
    let lastMessage: Message
    let unreadMessagesQuantity: Int
}
