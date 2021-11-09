//
//  CurrencyListViewModelProtocol.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 05.10.2021.
//

import Foundation

protocol CurrencyListViewModelProtocol {    
    var delegate: CurrencyListViewModelDelegate? { get set }
    
    func loadListData()
}

extension CurrencyListViewModelProtocol {
    func handleError(_ error: Error) {
        print(error)
    }
}
