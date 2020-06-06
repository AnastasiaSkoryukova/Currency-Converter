//
//  CurrencyConvertorVC.swift
//  Currency Converter
//
//  Created by Анастасия on 03.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

class CurrencyConvertorVC: UIViewController {
    var selectedCurrency: String?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstCurrencyTextField: UITextField!
    @IBOutlet var secondCurrencyTextField: UITextField!
    @IBOutlet var firstAmountTextField: UITextField!
    @IBOutlet var secondAmountTextField: UITextField!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var infoButton: UIButton!
    
    var currencyTextFieldsArray: [UITextField] = []
    var amountTextFieldsArray: [UITextField] = []
    let currencyPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureButtons()
        createDismissTapGesture ()
    }
    
    
    func createDismissTapGesture () {
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    
    func configureCurrencyTextFields() {
            currencyTextFieldsArray.append(firstCurrencyTextField)
            currencyTextFieldsArray.append(secondCurrencyTextField)
            amountTextFieldsArray.append(firstAmountTextField)
            amountTextFieldsArray.append(secondAmountTextField)
            currencyPicker.delegate = self
            currencyPicker.reloadComponent(0)
        for currencyTextField in currencyTextFieldsArray {
            currencyTextField.inputView = currencyPicker
        }
            
            //        dismiss
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let toolbarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolBarButtonAction))
            toolbar.setItems([toolbarButton], animated: true)
            toolbar.isUserInteractionEnabled = true
        for currencyTextField in currencyTextFieldsArray {
            currencyTextField.inputAccessoryView = toolbar
        }
        }
        @objc func toolBarButtonAction() {
            view.endEditing(true)
        }
    
    
    func configureButtons() {
        convertButton.layer.cornerRadius = 12
        infoButton.layer.cornerRadius = 12
    }
    
    }


extension CurrencyConvertorVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate {
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
            firstCurrencyTextField.text = selectedCurrency
        } else {
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
}



