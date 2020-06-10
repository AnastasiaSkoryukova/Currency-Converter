//
//  CurrencyConvertorVC.swift
//  Currency Converter
//
//  Created by Анастасия on 03.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit

class CurrencyConverterVC: UIViewController {
    var selectedCurrency: String?
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var firstCurrencyTextField: CurrencyConverterTextField!
    @IBOutlet var secondCurrencyTextField: CurrencyConverterTextField!
    @IBOutlet var firstAmountTextField: CurrencyConverterTextField!
    @IBOutlet var secondAmountTextField: CurrencyConverterTextField!
    @IBOutlet var convertButton: UIButton!
    
    
    var currencyTextFieldsArray: [UITextField] = []
    var amountTextFieldsArray: [UITextField] = []
    let currencyPicker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureAmountTextFields()
        configureConvertButton()
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
    
    
    func configureAmountTextFields() {
        amountTextFieldsArray.append(firstAmountTextField)
        amountTextFieldsArray.append(secondAmountTextField)
        for amountTextField in amountTextFieldsArray {
            amountTextField.delegate = self
        }
    }
    
    func configureConvertButton() {
        convertButton.layer.cornerRadius = 12
        convertButton.layer.borderColor = UIColor.systemGray2.cgColor
        convertButton.layer.borderWidth = 2
    }
    
    
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    let url = URL(string: "http://apilayer.net/api/live?access_key=155810ee37654a467647828de84a5eed&currencies=RUB&source=USD&format=1")
    
    
    }


extension CurrencyConverterVC: NetworkManagerDelegate {
    func getCurrency(from firstCurrencyTextField: String, from secondCurrencyTextField: String, from firstAmountTextField: String){
        self.firstCurrencyTextField.text! = firstCurrencyTextField
        self.secondCurrencyTextField.text! = secondCurrencyTextField
        self.firstAmountTextField.text! = firstAmountTextField
        
    }
}


