//
//  ServiceLayer.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 11.10.2021.
//

import Foundation

// ServiceLayer must be singltone or declared on AppDelegate and transmitted throught coordinators
// We need serviceLayer to use an object that knows how to get hold of all of the dataProviders to avoid dependencies in the whole project

class ServiceLayer {
    var currencyDataProvider: CurrencyDataProviding
    
    init(currencyDataProvider: CurrencyDataProviding) {
        self.currencyDataProvider = currencyDataProvider
    }
}

extension ServiceLayer: CurrencyDataProviderHolding {}
