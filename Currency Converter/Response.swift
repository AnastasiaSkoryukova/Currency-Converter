//
//  Response.swift
//  Currency Converter
//
//  Created by Анастасия on 11.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var rates: Currency?
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rates = try container.decode(Currency.self, forKey: .rates)
    }
}
