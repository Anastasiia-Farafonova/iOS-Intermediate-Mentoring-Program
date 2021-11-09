//
//  CurrencyDataModel.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

typealias CurrencyDataResult = Result<[CurrencyData], Error>

class CurrencyDataProvider: CurrencyDataProviding {
    var currencyListData: [CurrencyData] = [CurrencyData(name: "Name", date: Date(), price: 123.45)]

    func getCurrencyList(for interval: TimeInterval, completion: @escaping (CurrencyDataResult) -> Void) {
        // Here we can make requests
        completion(.success(currencyListData))
        return
    }
}
