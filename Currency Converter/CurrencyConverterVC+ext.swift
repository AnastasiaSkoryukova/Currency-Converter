//
//  CurrencyConverterVC+ext.swift
//  Currency Converter
//
//  Created by Анастасия on 08.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

extension CurrencyConverterVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleName = ("\(currencyList[row].abbreviation) - \(currencyList[row].name)")
        return titleName
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyList[row].abbreviation
        if firstCurrencyTextField.isFirstResponder {
            currencyPicker.selectRow(0, inComponent: 0, animated: true)
            

            firstCurrencyTextField.text = selectedCurrency
            currencyPicker.selectRow(0, inComponent: 0, animated: true)
        } else {
            currencyPicker.selectRow(0, inComponent: 0, animated: true)
            
            secondCurrencyTextField.text = selectedCurrency
            
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else { label = UILabel() }
        label.text = ("\(currencyList[row].abbreviation) - \(currencyList[row].name)")
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    
//    Making amount textFields to contain only numbers and comma for separation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string == string.filter("0123456789.".contains)
    }
}
