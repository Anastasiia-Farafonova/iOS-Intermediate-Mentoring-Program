//
//  MainListViewModel.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 07.01.2022.
//

import Combine

class ListViewModel: ObservableObject {

    @Published var list: [[PizzaItem]] = []
    
    private let model: MenuModel
    private var cancellables: [AnyCancellable] = []
    
    init(model: MenuModel) {
        self.model = model
        self.model
            .$sections
            .map { sections in
                sections.map { $0.map { self.setCorrectNameAndOrder($0) } }
            }
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
    }
    
    func moveItem(_ item: PizzaItem) {
        let nextSection = item.indexPath.section + 1
        
        if model.sections.count <= nextSection {
            model.moveItem(item, to: 0)
        } else {
            model.moveItem(item, to: nextSection)
        }
    }
    
    func replace(_ item: PizzaItem, with newItem: PizzaItem) {
        list[item.indexPath.section][item.indexPath.row] = newItem
    }
    
    private func setCorrectNameAndOrder(_ newItem: PizzaItem) -> PizzaItem {
        let localItems = Set(self.list.flatMap { $0 })

        var localItem = localItems.first { $0.id == newItem.id } ?? newItem
        localItem.indexPath = newItem.indexPath
        
        return localItem
    }
}
