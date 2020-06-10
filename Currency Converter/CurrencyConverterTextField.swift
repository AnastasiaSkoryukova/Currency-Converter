//
//  CurrencyConverterTextField.swift
//  Currency Converter
//
//  Created by Анастасия on 08.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

class CurrencyConverterTextField: UITextField {
    override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 6
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray3.cgColor
    textColor = .label
    tintColor = .label
    textAlignment = .center
}
}
