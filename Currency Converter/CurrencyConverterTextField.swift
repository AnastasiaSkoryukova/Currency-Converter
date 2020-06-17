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


//        let baseCurrency = self.firstCurrencyTextField.text!
//        let secondCurrency = self.secondCurrencyTextField.text!
//        let apiUrl = "https://api.ratesapi.io/api/latest?base=\(baseCurrency)&symbols=\(secondCurrency)"
//        let url = URL(string: apiUrl)
//        guard url != nil else { return }
//        let session = URLSession.shared
//        let task = session.dataTask(with: url!) { (data, response, error) in
//
//            if error != nil || data == nil { return }
//
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(Response.self, from: data!)
//                let rate = response.rates?.rates.map { $0.value }
//                guard self.firstAmountTextField.text != nil else { return }
//                let firstAmount = self.firstAmountTextField.text
//                let total = (rate?.first!)! * firstAmount!.toDouble()!
//                self.amountLabel.text = String(total)
//
//            }
//
//            catch {
//                self.showAlert(title: "Something went wrong", message: "The error occurred, please try again")
//            }
//            self.currencyPicker.reloadAllComponents()
//        }
//
//        task.resume()
//    }
//    @objc func convertButtonAction() {
//        getCurrencyRates()
//
//
