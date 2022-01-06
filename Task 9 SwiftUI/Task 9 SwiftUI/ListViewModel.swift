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
                let localItems = Set(self.list.flatMap { $0 })
    
                let newSections = sections.map { section in
                    return section.map { sectionItem in
                        localItems.first { $0.id == sectionItem.id } ?? sectionItem
                    }
                }
                
                return newSections
            }
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
    }
    
    func moveItem(_ item: PizzaItem, from section: [PizzaItem]) {
        guard let sectionIndex = list.firstIndex(of: section) else { return }
        
        let nextSection = sectionIndex + 1
        
        if model.sections.count <= nextSection {
            model.moveItem(item, sectionIndex: sectionIndex, to: 0)
        } else {
            model.moveItem(item, sectionIndex: sectionIndex, to: nextSection)
        }
    }
    
    func replace(_ item: PizzaItem, with newItem: PizzaItem, in section: [PizzaItem]) {
        guard let sectionIndex = list.firstIndex(of: section),
                let itemIndex = list[sectionIndex].firstIndex(of: item) else { return }
        
        list[sectionIndex][itemIndex] = newItem
    }
}
