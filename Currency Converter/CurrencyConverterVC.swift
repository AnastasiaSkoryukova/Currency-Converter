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
    @IBOutlet var firstCurrencyTextField: UITextField!
    @IBOutlet var secondCurrencyTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var currencyChangeButton: UIButton!
    
    var selectedCurrency: String?
    var displayedCurrency: Int?
    
    var currencyTextFieldsArray: [UITextField] = []
    let firstCurrencyPicker = UIPickerView()
    let secondCurrencyPicker = UIPickerView()
    
    var amountInDouble: Double?
    var baseCurrency = ""
    var secondCurrency = ""
    var currencyAmount = ""
    var result: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureAmountAndResultTextFields()
        configureConvertButton()
        createDismissTapGesture ()
        configureCurrencyChangeButton()
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
        guard let currencyAmount = amountTextField.text else { print ("has no amount in amount textfield")
            return}
        self.currencyAmount = currencyAmount
        let amountInDouble = Double(currencyAmount)
        
        guard amountInDouble != nil else { return }
        self.amountInDouble = amountInDouble!
    }
    
    
    func configureCurrencyTextFields() {
        currencyTextFieldsArray.append(firstCurrencyTextField)
        currencyTextFieldsArray.append(secondCurrencyTextField)
        firstCurrencyPicker.delegate = self
        secondCurrencyPicker.delegate = self
        firstCurrencyTextField.inputView = firstCurrencyPicker
        secondCurrencyTextField.inputView = secondCurrencyPicker
        for currencyTextField in currencyTextFieldsArray {
            currencyTextField.addBottomBorderWithColor(color: UIColor.systemBlue, width: 3)
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
    
    
    func configureAmountAndResultTextFields() {
        amountTextField.delegate = self
        amountTextField.keyboardType = .decimalPad
//        Adding the bottom line instead of the textField borders
        amountTextField.addBottomBorderWithColor(color: UIColor.systemBlue, width: 3)
        resultTextField.addBottomBorderWithColor(color: UIColor.systemBlue, width: 3)
    }
    
    
    func configureCurrencyChangeButton() {
        currencyChangeButton.addTarget(self, action: #selector(currencyChangeButtonAction), for: .touchUpInside)
    }
    
    @objc func currencyChangeButtonAction() {
        (firstCurrencyTextField.text, secondCurrencyTextField.text) = (secondCurrencyTextField.text, firstCurrencyTextField.text)
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
    
    
    func configureConvertButton() {
        convertButton.layer.cornerRadius = 22
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















