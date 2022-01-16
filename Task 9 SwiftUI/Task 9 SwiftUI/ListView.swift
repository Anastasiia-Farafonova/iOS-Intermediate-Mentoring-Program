//
//  MainView.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 06.01.2022.
//

import SwiftUI

struct ListView: View {
    @StateObject var listViewModel: ListViewModel
    
    var body: some View {
        List {
            ForEach(listViewModel.list, id: \.self) { section in
                Section {
                    ForEach(section) { item in
                        Button {
                            self.moveToNextSection(item: item)
                        } label: {
                            PizzaRowView(item: .init(get: {
                                item
                            }, set: { newItem in
                                listViewModel.replace(item, with: newItem)
                            }))
                        }
                    }
                }
            }
        }
    }
    
    private func moveToNextSection(item: PizzaItem) {
        listViewModel.moveItem(item)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(listViewModel: ListViewModel(model: MenuModel()))
    }
}
