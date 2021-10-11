//
//  CurrencyData.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

struct CurrencyListData: Codable {
    let currencyList: [CurrencyData]
}

struct CurrencyData: Codable {
    let name: String
    let date: Date
    let price: Double
}
