//
//  CurrencyModel.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 11.10.2021.
//

import Foundation

protocol CurrencyModelProtocol {
    func getCurrencyLint(for interval: TimeInterval, completion: @escaping (CurrencyListData?, Error?) -> Void)
}

class CurrencyModel: CurrencyModelProtocol {
    // We need this typealias to avoid unnecessary dependencies.
    // So here we can only declare those protocols that we'll use (by using & SomeAnotherServiceHolderProtocol)
    typealias Context = CurrencyDataProviderHolderProtocol
    private let serviceLayer: Context
    
    init(serviceLayer: Context) {
        self.serviceLayer = serviceLayer
    }
    
    func getCurrencyLint(for interval: TimeInterval, completion: @escaping (CurrencyListData?, Error?) -> Void) {
        serviceLayer.currencyDataProvider.getCurrencyList(for: interval, completion: completion)
    }
}
