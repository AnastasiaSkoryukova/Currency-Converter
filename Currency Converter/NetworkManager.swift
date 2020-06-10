//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Анастасия on 10.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

protocol NetworkManagerDelegate: class {
    func getCurrency(from firstCurrencyTextField: String, from secondCurrencyTextField: String, from firstAmountTextField: String)
}

class NetworkManager {
    weak var delegate: NetworkManagerDelegate!
    var firstCurrencyTextField: String!
    var secondCurrencyTextField: String!
    var firstAmountTextField: String!
    
}
