//
//  Currency.swift
//  Currency Converter
//
//  Created by Анастасия on 09.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    var rates: [String: Double] = [ : ]
    
    
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rates = try container.decode([String:Double].self, forKey: .rates)
}
}
