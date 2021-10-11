//
//  CurrencyDataModel.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

class CurrencyDataProvider: CurrencyDataProviderProtocol {
    var currencyListData: CurrencyListData = CurrencyListData(currencyList: [CurrencyData(name: "Name", date: Date(), price: 123.45)])
        
    func getCurrencyList(for interval: TimeInterval, completion: @escaping (CurrencyListData?, Error?) -> Void) {
        // Here we can make requests
        completion(currencyListData, nil)
        return
    }
}
