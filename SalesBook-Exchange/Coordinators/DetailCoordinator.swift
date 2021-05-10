//
//  DetailCoordinator.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 04/05/2021.
//

import UIKit

class DetailCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let currencySymbol: String

    init(navigationController: UINavigationController, currencySymbol: String) {
        self.navigationController = navigationController
        self.currencySymbol = currencySymbol
    }

    func start() {
        let vc = DetailCurrencyViewController.instantiate()
        vc.viewModel = CurrencyDetailViewModel(currencySymbol: currencySymbol)
        vc.viewModel.getHistoricalCurrency()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
