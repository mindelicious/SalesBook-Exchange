//
//  MainCurrencyViewController.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 04/05/2021.
//

import UIKit
import Alamofire

class MainCurrencyViewController: UIViewController, Storyboarded {
    
    var currencyDetail: ((String) -> Void)?
    var viewModel = CurrencyViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        getData()
    }
    
    func getData() {
        viewModel.getCurrency()
        
        viewModel.showAlertClosure = { [weak self] in
            self?.alert(title: AlertConstans.somethingWrong, actionButtonTitle: AlertConstans.reload) {
                self?.viewModel.getCurrency()
            }
        }
        
        viewModel.didCurrencyGet = {
            self.tableView.reloadData()
        }
    }
    
    func responseAlert() {
        let alert = UIAlertController(title: AlertConstans.somethingWrong,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertConstans.cancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: AlertConstans.reload, style: .default, handler: { [weak self] _ in
            self?.viewModel.getCurrency()
        }))
        self.present(alert, animated: true)
    }
}

extension MainCurrencyViewController: UITableViewDelegate, UITableViewDataSource {

    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellConstants.currencyCell, bundle: nil), forCellReuseIdentifier: CellConstants.currencyCell)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.currencyCell, for: indexPath) as! CurrencyCell
        cell.showData(name: viewModel.setKey(indexPath: indexPath), rate: viewModel.setValue(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keys = Array(viewModel.currencyData.keys)
        let item = keys[indexPath.row]
        
        currencyDetail?(item)
    }
}


