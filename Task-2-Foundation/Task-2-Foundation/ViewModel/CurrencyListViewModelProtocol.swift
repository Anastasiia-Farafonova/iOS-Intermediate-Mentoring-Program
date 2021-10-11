//
//  CurrencyListViewModelProtocol.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

protocol CurrencyListViewModelProtocol {
    var listData: CurrencyListData? { get set }
    
    func handleError(_ error: Error)
}

extension CurrencyListViewModelProtocol {
    func handleError(_ error: Error) {
        print(error)
    }
}
