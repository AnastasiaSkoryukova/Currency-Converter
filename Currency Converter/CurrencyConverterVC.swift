//
//  CurrencyConvertorVC.swift
//  Currency Converter
//
//  Created by Анастасия on 03.06.2020.
//  Copyright © 2020 Anastasia Skoryukova. All rights reserved.
//

import UIKit


class CurrencyConverterVC: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstCurrencyTextField: CurrencyConverterTextField!
    @IBOutlet var secondCurrencyTextField: CurrencyConverterTextField!
    @IBOutlet var firstAmountTextField: CurrencyConverterTextField!
    @IBOutlet var resultTextField: CurrencyConverterTextField!
    @IBOutlet var convertButton: UIButton!
    
    var selectedCurrency: String?
    
    
    var currencyTextFieldsArray: [UITextField] = []
    let currencyPicker = UIPickerView()
    
    var amountInDouble: Double?
    var baseCurrency = ""
    var secondCurrency = ""
    var currencyAmount = ""
    var result: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureAmountTextField()
        configureConvertButton()
        createDismissTapGesture ()
    }
    
    
    func createDismissTapGesture () {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
//    Gets the value from textFields and put it into the view controller properties
    func getTextFromTextFields () {
        guard let baseCurrency = firstCurrencyTextField.text else { print ("has no currency in first currency textfield")
            return
        }
        self.baseCurrency = baseCurrency
        guard let secondCurrency = secondCurrencyTextField.text else { print ("has no currency in second currency textfield")
            return}
        self.secondCurrency = secondCurrency
        guard let currencyAmount = firstAmountTextField.text else { print ("has no amount in amount textfield")
            return}
        self.currencyAmount = currencyAmount
        let amountInDouble = Double(currencyAmount)
        let roundedAmountInDouble = amountInDouble?.round(to: 0)
        guard roundedAmountInDouble != nil else { return }
        self.amountInDouble = roundedAmountInDouble!
    }
    
    
    func configureCurrencyTextFields() {
        currencyTextFieldsArray.append(firstCurrencyTextField)
        currencyTextFieldsArray.append(secondCurrencyTextField)
        currencyPicker.delegate = self
        
        for currencyTextField in currencyTextFieldsArray {
            currencyTextField.inputView = currencyPicker
        }
        
        //        dismiss Keyboard
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
    
    
    func configureAmountTextField() {
        firstAmountTextField.delegate = self
    }
    
    
    func configureConvertButton() {
        convertButton.layer.cornerRadius = 12
        convertButton.layer.borderColor = UIColor.systemGray2.cgColor
        convertButton.layer.borderWidth = 2
        convertButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction () {
        getTextFromTextFields()
        NetworkManager.shared.getCurrency(baseCurrency: baseCurrency, secondCurrency: secondCurrency) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let rate):
                self.makeCalculation(with: rate)
            case .failure( _):
                print(CurrencyError.invalidData)
            }
            self.updateUI()
        }
    }
    
//    Getting the result of calculation (currency rate * currency amount)
    func makeCalculation(with rate: Currency) {
        guard let amountInDouble = self.amountInDouble else { return }
        let result = amountInDouble * rate.result
        self.result = result.round(to: 2)
    }
    
//    Display the result of conversion at the amount textfield
    func updateUI () {
        DispatchQueue.main.async {
            self.resultTextField.text = self.result?.string
        }
    }
}















