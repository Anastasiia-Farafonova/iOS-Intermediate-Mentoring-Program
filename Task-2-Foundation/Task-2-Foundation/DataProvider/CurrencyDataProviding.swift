//
//  CurrencyDataModelProtocol.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

protocol CurrencyDataProviding {
    var currencyListData: [CurrencyData] { get }
    
    func getCurrencyList(for interval: TimeInterval, completion: @escaping (CurrencyDataResult) -> Void)
}
