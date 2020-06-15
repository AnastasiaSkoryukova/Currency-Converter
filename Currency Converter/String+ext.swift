//
//  String+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 15.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
