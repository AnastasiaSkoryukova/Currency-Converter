//
//  Double+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 16.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
