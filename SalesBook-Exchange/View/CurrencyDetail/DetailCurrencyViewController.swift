//
//  DetailCurrencyViewController.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 04/05/2021.
//

import UIKit
import Alamofire

class DetailCurrencyViewController: UIViewController, Storyboarded {
    weak var coordinator: DetailCoordinator?
    var viewModel: CurrencyDetailViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        getData()
    }
    
    func getData() {

        viewModel.showAlertClosure = { [weak self] in
            self?.alert(title: AlertConstans.somethingWrong, actionButtonTitle: AlertConstans.reload, completion: {
                self?.getData()
            })
        }
        
        viewModel.didCurrencyGet = {
            self.tableView.reloadData()
        }
    }
}

extension DetailCurrencyViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellConstants.currencyDetailCell, bundle: nil), forCellReuseIdentifier: CellConstants.currencyDetailCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.historicalRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.currencyDetailCell, for: indexPath) as! CurrencyDetailCell
        cell.showData(name: viewModel.currencySymbol, rate: viewModel.setValue(indexPath: indexPath), date: viewModel.setDate(indexPath: indexPath))
        return cell
    }

}
