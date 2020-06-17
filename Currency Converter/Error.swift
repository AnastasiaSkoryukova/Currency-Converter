//
//  Alert.swift
//  Currency Converter
//
//  Created by Анастасия on 08.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation

enum CurrencyError: String, Error {
    case invalidCurrencyType = "This currency type created invalid request. Please try again later"
    case unableToComplete = "Unable to complete your request, Please check your Internet connection"
    case invalidResponse = "Invalid response from the server. Please try again later"
    case invalidData = "The data received from the server is invalid. Please try again later"
}
