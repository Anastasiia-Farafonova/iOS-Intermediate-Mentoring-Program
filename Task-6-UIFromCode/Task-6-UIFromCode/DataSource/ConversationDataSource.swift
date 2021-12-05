//
//  ConversationDataSource.swift
//  Task-6-UIFromCode
//
//  Created by Anastasiia Farafonova on 12.12.2021.
//

import Foundation

struct ConversationDataSource {
    private var randomNumber: Int {
        return Int.random(in: 1...30)
    }
    
    func getDialogs(quantity: Int) -> [Conversation] {
        let range = 1...quantity
        return Array(range.map { _ in createDialog() })
    }
    
    private func createDialog() -> Conversation {
        return Conversation(avatar: createAvatar(),
                            members: randomNumber % 3,
                            name: createName(),
                            lastMessage: createMessage(),
                            unreadMessagesQuantity: createUnreadMessagesQuantity())
    }
    
    private func createMessage() -> Message {
        return Message(text: createLastMessage(), time: createTime())
    }
    
    private func createTime() -> String {
        let formatter: NumberFormatter = {
            let temp = NumberFormatter()
            temp.minimumIntegerDigits = 2
            return temp
        }()
        
        let minutes = formatter.string(from: NSNumber(value: randomNumber)) ?? "00"
        let hour = Int.random(in: 1...12)
        
        return "\(hour):\(minutes)"
    }
    
    private func createAvatar() -> String? {
        let imageNames = ["1", "2", "3", "4", "5", "6"]
        return imageNames[randomNumber % imageNames.count]
    }
    
    private func createName() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
        return String((0..<randomNumber).map{ _ in letters.randomElement() ?? " " })
    }
    
    private func createLastMessage() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
        return String((0..<randomNumber).map{ _ in letters.randomElement() ?? " " })
    }
    
    private func createUnreadMessagesQuantity() -> Int {
        return Bool.random() ? randomNumber : 0
    }
}
