//
//  DialogModel.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import Foundation

class DialogsModel {
    private var conversationDataSource = ConversationDataSource()
    private let dialogsQuantity = 30
    
    func getConversations() -> [ConversationViewModel] {
        conversationDataSource.getDialogs(quantity: dialogsQuantity).map { ConversationViewModel(conversation: $0) }
    }
}
