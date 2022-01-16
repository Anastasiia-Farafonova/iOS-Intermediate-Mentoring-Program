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
            [PizzaItem(id: 1, name: "Pizza #1", price: 1, image: "1", indexPath: IndexPath(row: 0, section: 0)),
             PizzaItem(id: 2, name: "Pizza #2", price: 2, image: "2", indexPath: IndexPath(row: 1, section: 0)),
             PizzaItem(id: 3, name: "Pizza #3", price: 3, image: "3", indexPath: IndexPath(row: 2, section: 0))],
            
            [PizzaItem(id: 4, name: "Pizza #4", price: 4, image: "4", indexPath: IndexPath(row: 0, section: 1)),
             PizzaItem(id: 5, name: "Pizza #5", price: 5, image: "5", indexPath: IndexPath(row: 1, section: 1)),
             PizzaItem(id: 6, name: "Pizza #6", price: 6, image: "6", indexPath: IndexPath(row: 2, section: 1))],
            
            [PizzaItem(id: 7, name: "Pizza #7", price: 7, image: "7", indexPath: IndexPath(row: 0, section: 2)),
             PizzaItem(id: 8, name: "Pizza #8", price: 8, image: "8", indexPath: IndexPath(row: 1, section: 2)),
             PizzaItem(id: 9, name: "Pizza #9", price: 9, image: "9", indexPath: IndexPath(row: 2, section: 2)),
             PizzaItem(id: 10, name: "Pizza #10", price: 10, image: "10", indexPath: IndexPath(row: 3, section: 2))]
        ]
    }()
    
    func moveItem(_ item: PizzaItem, to newIndex: Int) {
        var sections = sections
        var newItem = item
        
        newItem.indexPath = IndexPath(row: sections[newIndex].count, section: newIndex)

        sections[item.indexPath.section].remove(at: item.indexPath.row)
        sections[newIndex].append(newItem)
        
        
        self.sections = sections
    }
}
