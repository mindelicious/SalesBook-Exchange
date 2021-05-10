//
//  CurrencyDetailCell.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 09/05/2021.
//

import UIKit

class CurrencyDetailCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    
    func showData(name: String, rate: String, date: String) {
        currencyNameLabel.text = name
        currencyRateLabel.text = rate
        dateLabel.text = date
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyRateLabel.text = nil
        currencyNameLabel.text = nil
        dateLabel.text = nil
    }
    
}
