//
//  Coordinator.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 04/05/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
