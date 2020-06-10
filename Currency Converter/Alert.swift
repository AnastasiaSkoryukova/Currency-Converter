//
//  Alert.swift
//  Currency Converter
//
//  Created by Анастасия on 08.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit



func showAlert (title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
}
