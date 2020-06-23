//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Анастасия on 20.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

class NetworkManager {
    
static let shared = NetworkManager()
    private let baseUrl = "https://api.exchangerate.host/"
    private init () {}
    
    
func getCurrency (baseCurrency: String, secondCurrency: String, completed: @escaping(Result <Currency, Error>) -> Void) {
    
    let endpoint = baseUrl + "convert?from=\(baseCurrency)&to=\(secondCurrency)"
    
    guard let url = URL(string: endpoint) else {
        completed(.failure(CurrencyError.invalidCurrencyType))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let _ = error {
            completed (.failure(CurrencyError.unableToComplete))
            return
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completed(.failure(CurrencyError.invalidResponse))
            return
        }
        guard let data = data else {
            completed(.failure(CurrencyError.invalidData))
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let rates = try decoder.decode(Currency.self, from: data)
            completed(.success(rates))
        } catch {
                completed(.failure(CurrencyError.invalidData))
            }
        }
        task.resume()
    }
}

