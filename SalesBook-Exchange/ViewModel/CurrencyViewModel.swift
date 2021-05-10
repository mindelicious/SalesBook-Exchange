//
//  CurrencyViewModel.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 05/05/2021.
//
import UIKit

class CurrencyViewModel {

    let networkManager: NetworkManagerProtocol
    var currencyData = [String: Double]()
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
  
    var showAlertClosure: (() -> Void)?
    var didCurrencyGet:(() -> Void)?

    func getCurrency() {
        networkManager.getCurrencyList() { [weak self] result in
            switch result {
            case .success(let currencyModel):
                self?.currencyData = currencyModel.rates
                self?.didCurrencyGet?()
            case .failure(_):
                self?.showAlertClosure?()
            }
        }
    }
    
    func setKey(indexPath: IndexPath) -> String {
       return Array(currencyData.keys)[indexPath.row]
    }
    
    func setValue(indexPath: IndexPath) -> String {
        let doubleValue = Array(currencyData.values)[indexPath.row]
       return String(format: "%.2f", doubleValue)
    }
}
