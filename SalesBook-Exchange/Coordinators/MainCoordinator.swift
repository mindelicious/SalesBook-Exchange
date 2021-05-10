//
//  MainCoordinator.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 04/05/2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = MainCurrencyViewController.instantiate()
        vc.currencyDetail = { [weak self] item in
            self?.detailCurrency(currencySymbol: item)
        }
        navigationController.pushViewController(vc, animated: false)
    }
    
    func detailCurrency(currencySymbol: String) {
        let child = DetailCoordinator(navigationController: navigationController, currencySymbol: currencySymbol)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let detailViewController = fromViewController as? DetailCurrencyViewController {
            childDidFinish(detailViewController.coordinator)
        }
    }
}
