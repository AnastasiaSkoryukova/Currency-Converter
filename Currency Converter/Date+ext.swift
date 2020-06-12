//
//  Date+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 11.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation


extension Date {
    func convertToYearMonthDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM DD"
        return dateFormatter.string(from: self)
    }
}
