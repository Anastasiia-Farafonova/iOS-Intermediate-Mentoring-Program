//
//  ViewController.swift
//  Task-2-Foundation
//
//  Created by Anastasiia Farafonova on 04.10.2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: CurrencyListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyDataProvider = CurrencyDataProvider()
        let serviceLayer = ServiceLayer(currencyDataProvider: currencyDataProvider)
        let model = CurrencyModel(serviceLayer: serviceLayer)
        
        // Creation of view model must be on coordinators. It is here just for example
        
        viewModel = CurrencyListViewModel(model: model)
        viewModel?.delegate = self
        viewModel?.loadListData()
    }
}

extension ViewController: CurrencyListViewModelDelegate {
    func viewModel(_ viewModel: CurrencyListViewModel, didReceiveData data: [CurrencyData]) {
        print(data)
    }
}
