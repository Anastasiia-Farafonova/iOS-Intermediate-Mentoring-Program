//
//  PizzaMenuModel.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 06.01.2022.
//

import Foundation

class MenuModel: ObservableObject {
    @Published var sections: [[PizzaItem]] = {
        [
            [PizzaItem(id: 1, name: "Pizza #1", price: 1, image: "1"),
             PizzaItem(id: 2, name: "Pizza #2", price: 2, image: "2"),
             PizzaItem(id: 3, name: "Pizza #3", price: 3, image: "3")],
            
            [PizzaItem(id: 4, name: "Pizza #4", price: 4, image: "4"),
             PizzaItem(id: 5, name: "Pizza #5", price: 5, image: "5"),
             PizzaItem(id: 6, name: "Pizza #6", price: 6, image: "6")],
            
            [PizzaItem(id: 7, name: "Pizza #7", price: 7, image: "7"),
             PizzaItem(id: 8, name: "Pizza #8", price: 8, image: "8"),
             PizzaItem(id: 9, name: "Pizza #9", price: 9, image: "9"),
             PizzaItem(id: 10, name: "Pizza #10", price: 10, image: "10")]
        ]
    }()
    
    func moveItem(_ item: PizzaItem, sectionIndex: Int, to newIndex: Int) {
        var sections = sections
        
        sections[sectionIndex].removeAll { $0.id == item.id }
        sections[newIndex].append(item)
        
        self.sections = sections
    }
}
