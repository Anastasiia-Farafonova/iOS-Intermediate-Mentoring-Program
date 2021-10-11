//
//  CurrencyListsDataProviderHolderProtocol.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 11.10.2021.
//

import Foundation

protocol CurrencyDataProviderHolderProtocol: AnyObject {
    var currencyDataProvider: CurrencyDataProviderProtocol { get }
}
