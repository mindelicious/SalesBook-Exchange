//
//  CurrencyModel.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 05/05/2021.
//

struct CurrencyModel: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}
