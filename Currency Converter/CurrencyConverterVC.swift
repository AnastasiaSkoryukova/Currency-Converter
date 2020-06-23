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
    @IBOutlet var resultTextField: CurrencyConverterTextField!
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var convertButton: UIButton!
    
    var source = ""
    var currencies = ""
    
    var currencyTextFieldsArray: [UITextField] = []
    let currencyPicker = UIPickerView()
    
    var currencyRateDictionary: [String: Double] = [ : ]
    var currencyRate: Double?
    var amountInDouble: Double?
    var baseCurrency = ""
    var secondCurrency = ""
    var currencyResult: Double?
    var currencyAmount = ""
    var result: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureAmountTextFieldAndResultTextField()
        configureConvertButton()
        createDismissTapGesture ()
        
    }
    
    
    func createDismissTapGesture () {

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
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
        let amountInDouble = Double(self.firstAmountTextField.text!)
        let roundedAmountInDouble = amountInDouble?.round(to: 0)
        guard roundedAmountInDouble != nil else { return }
        self.amountInDouble = roundedAmountInDouble!
        
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
    
    
    func configureAmountTextFieldAndResultTextField() {
        firstAmountTextField.delegate = self
        
    }
    
    
    func configureConvertButton() {
        convertButton.layer.cornerRadius = 12
        convertButton.layer.borderColor = UIColor.systemGray2.cgColor
        convertButton.layer.borderWidth = 2
        convertButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
    
    func makeCalculation(with rate: Currency) {
        guard let amountInDouble = self.amountInDouble else { return }
        let result = amountInDouble * rate.result
        self.result = result.round(to: 2)
        
        }
    func updateUI () {
        DispatchQueue.main.async {
            self.resultTextField.text = self.result?.string
        }
        
        
    }
}
    
    
    
    
    
        
       
        
        
            

        
        
  

