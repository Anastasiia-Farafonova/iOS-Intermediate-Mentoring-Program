//
//  CurrencyListViewModel.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 04.10.2021.
//

import Foundation

protocol CurrencyListViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: CurrencyListViewModel, didReceiveData data: [CurrencyData])
}

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    weak var delegate: CurrencyListViewModelDelegate?
    let model: CurrencyModelProtocol
    
    init(model: CurrencyModelProtocol) {
        self.model = model
    }
    
    func loadListData() {
        model.getCurrencyLint(for: TimeInterval()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currencyList):
                self.delegate?.viewModel(self, didReceiveData: currencyList)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
}
