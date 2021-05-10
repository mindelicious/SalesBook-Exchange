//
//  NetworkManager.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 05/05/2021.
//

import UIKit
import Alamofire

protocol NetworkManagerProtocol {
    func getCurrencyList(onResult: @escaping (Result<CurrencyModel, AFError>) -> Void)  
    
    func getCurrencyHistory(date: String, currencySymbol: String, onCurrecyGet: @escaping (Result<CurrencyModel, AFError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let parameters: [String: String] = [
        "access_key" : Secret.apiKey
    ]

    // http://api.exchangeratesapi.io/v1/latest?access_key=1121e7f30500c739e11e26e07383fc74
    private let allCurencyUrl: URL = URL(string: "http://api.exchangeratesapi.io/v1/latest")!
    private let historyCurrencyUrl: URL = URL(string: "http://api.exchangeratesapi.io/v1/")!
    
    func getCurrencyList(onResult: @escaping (Result<CurrencyModel, AFError>) -> Void) {

        AF.request(allCurencyUrl, parameters: parameters).responseDecodable(of: CurrencyModel.self) { response in
            onResult(response.result)
        }
    }
    #warning("wywal")
    //http://api.exchangeratesapi.io/v1/2013-03-16?access_key=1121e7f30500c739e11e26e07383fc74&symbols=USD,AUD,CAD,PLN,MXN
    func getCurrencyHistory(date: String, currencySymbol: String, onCurrecyGet: @escaping (Result<CurrencyModel, AFError>) -> Void) {
        
        let basicUrl = historyCurrencyUrl.appendingPathComponent("\(date)")
        let secParameters: [String: String] = [
            "access_key" : Secret.apiKey,
            "symbols": currencySymbol
        ]
        
        AF.request(basicUrl, parameters: secParameters).responseDecodable(of: CurrencyModel.self) { response in
            onCurrecyGet(response.result)
        }
    }
}

