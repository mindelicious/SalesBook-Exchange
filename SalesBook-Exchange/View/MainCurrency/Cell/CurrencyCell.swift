//
//  CurrencyCelll.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 06/05/2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    
    func showData(name: String, rate: String) {
        currencyNameLabel.text = name
        currencyRateLabel.text = rate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyRateLabel.text = nil
        currencyNameLabel.text = nil
    }
}
