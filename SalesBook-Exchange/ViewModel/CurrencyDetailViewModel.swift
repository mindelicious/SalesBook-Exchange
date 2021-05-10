//
//  CurrencyDetailViewModel.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 09/05/2021.
//

import UIKit
import Alamofire

class CurrencyDetailViewModel {

    let networkManager: NetworkManagerProtocol
    var historicalRates = [Double]()
    var historicalDates = [String]()
    var currencySymbol: String
    let group = DispatchGroup()

    var error: Error? {
        didSet { self.showAlertClosure?() }
    }

    var showAlertClosure: (() -> Void)?
    var didCurrencyGet:(() -> Void)?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared,
         currencySymbol: String) {
        self.networkManager = networkManager
        self.currencySymbol = currencySymbol
    }
 
    func getHistoricalCurrency() {
        var historicalDate = Date()
        for _ in 0...6 {
            group.enter()
            networkManager.getCurrencyHistory(date: historicalDate.formattedDate(), currencySymbol: currencySymbol) { [weak self] result in
                switch result {
                case .success(let currencyModel):
                    for value in currencyModel.rates.values {
                        self?.historicalRates.append(value)
                        self?.historicalDates.append(currencyModel.date)
                        self?.group.leave()
                    }
                case .failure(_):
                    self?.showAlertClosure?()
                    self?.group.leave()
                }
            }
            historicalDate.changeDays(by: -1)
        }
        group.notify(queue: .main) { [weak self] in
            self?.didCurrencyGet?()
        }
    }

    func setValue(indexPath: IndexPath) -> String {
        let doubleValue = historicalRates[indexPath.row]
        return String(format: "%.3f", doubleValue)
    }
    func setDate(indexPath: IndexPath) -> String {
        historicalDates.sort()
        return historicalDates[indexPath.row]
    }
}
