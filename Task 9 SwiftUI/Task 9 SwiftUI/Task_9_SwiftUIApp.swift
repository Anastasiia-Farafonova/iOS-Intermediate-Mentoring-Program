//
//  Task_9_SwiftUIApp.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 05.01.2022.
//

import SwiftUI

@main
struct Task_9_SwiftUIApp: App {
    var model = MenuModel()
    
    var body: some Scene {
        WindowGroup {
            ListView(listViewModel: ListViewModel(model: model))
        }
    }
}
