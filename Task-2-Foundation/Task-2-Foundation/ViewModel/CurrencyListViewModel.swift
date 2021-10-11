//
//  CurrencyListViewModel.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 04.10.2021.
//

import Foundation

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    let model: CurrencyModelProtocol
    var listData: CurrencyListData?
    
    init(model: CurrencyModelProtocol) {
        self.model = model
        getCurrencyLint()
    }
    
    func getCurrencyLint() {
        model.getCurrencyLint(for: TimeInterval()) { [weak self] currencyList, error in
            if let currencyList = currencyList {
                self?.listData = currencyList
            } else if let error = error {
                self?.handleError(error)
            }
        }
    }
}
