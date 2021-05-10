//
//  Date+Extensions.swift
//  SalesBook-Exchange
//
//  Created by Mateusz Danieluk on 07/05/2021.
//
import UIKit

extension Date {
    mutating func changeDays(by days: Int) {
        self = Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self)
    }
}
