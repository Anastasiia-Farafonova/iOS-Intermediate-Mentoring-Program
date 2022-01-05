//
//  DialogListViewModel.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import Foundation

class DialogListViewModel {
    let model: DialogsModel
    var conversationViewModels: [ConversationViewModel]
    
    init(model: DialogsModel) {
        self.model = model
        self.conversationViewModels = model.getConversations()
    }
    
    func fetchConversations(callback: @escaping () -> Void) {
        conversationViewModels += model.getConversations()
        callback()
    }
    
    func refresh(callback: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.conversationViewModels = self.model.getConversations()
            callback()
        }
    }
}
