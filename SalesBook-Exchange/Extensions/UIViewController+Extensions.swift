//
//  UIViewController+Extensions.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 10/05/2021.
//

import UIKit

extension UIViewController {
    func alert(title: String, actionButtonTitle: String, message: String = "", completion: @escaping () -> Void) {
    let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let reload = UIAlertAction(title: actionButtonTitle, style: .default, handler: { _ in completion() })
    alertController.addAction(reload)
    self.present(alertController, animated: true, completion: nil)
  }
}
