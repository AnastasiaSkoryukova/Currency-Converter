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
        networkCall()
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
        convertButton.addTarget(self, action: #selector(convertButtonAction), for: .touchUpInside)
    }
    
    
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func networkCall () {
        let baseCurrency = self.firstCurrencyTextField.text!
        let secondCurrency = self.secondCurrencyTextField.text!
        let apiUrl = "https://api.ratesapi.io/api/latest?base=\(baseCurrency)&symbols=\(secondCurrency)"
        let url = URL(string: apiUrl)
        guard url != nil else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil || data == nil { return }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data!)
            }
            
            catch {
                
            }
        }
        
        task.resume()
    }
    @objc func convertButtonAction() {
        print("Convert button was tapped")
        networkCall()
    }

}
