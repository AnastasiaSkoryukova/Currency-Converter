//
//  Dictionary+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 16.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import Foundation


extension Dictionary {
    func merged(with another: [Key: Value]) -> [Key: Value] {
        var result = self
        for entry in another {
            result[entry.key] = entry.value
        }
        return result
    }
}
