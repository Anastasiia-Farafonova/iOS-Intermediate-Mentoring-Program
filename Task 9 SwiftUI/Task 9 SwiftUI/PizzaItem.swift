//
//  PizzaItem.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 06.01.2022.
//

import Foundation
import Combine

struct PizzaItem: Identifiable, Hashable {
    var id: Int
    var name: String
    var price: Int
    var image: String
}
