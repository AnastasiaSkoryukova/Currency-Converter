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
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var convertButton: UIButton!
    
    
    
    var currencyTextFieldsArray: [UITextField] = []
    let currencyPicker = UIPickerView()
    
    var currencyRateDictionary: [String: Double] = [ : ]
    var currencyRate: Double?
    var amountInDouble: Double?
    var baseCurrency = ""
    var secondCurrency = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyTextFields()
        configureAmountTextFieldAndLabel()
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
    
    
    func configureAmountTextFieldAndLabel() {
        firstAmountTextField.delegate = self
        amountLabel.layer.borderColor = UIColor.systemGray3.cgColor
        amountLabel.layer.borderWidth = 2
        amountLabel.layer.cornerRadius = 6
        amountLabel.textColor = .label
        amountLabel.tintColor = .label
        amountLabel.textAlignment = .center
        
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
    
    
    
    
    func getCurrencyRates (from baseCurrency: String, to secondCurrency: String, completed: @escaping (Result<Currency, Error>) -> Void) {
        
        let baseUrl = "https://api.ratesapi.io/api/latest?"
        guard let baseCurrency = self.firstCurrencyTextField.text else { return }
        self.baseCurrency = baseCurrency
        guard let secondCurrency = self.secondCurrencyTextField.text else { return }
        self.secondCurrency = secondCurrency
        let endpoint = baseUrl + "base=\(baseCurrency)&symbols=\(secondCurrency)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(CurrencyError.invalidCurrencyType))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let _ = error {
                completed(.failure(CurrencyError.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(CurrencyError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(CurrencyError.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let resultCurrencyRate = try decoder.decode(Currency.self, from: data)
                completed(.success(resultCurrencyRate))
                let currencyRateWithName = self.currencyRateDictionary.merged(with: resultCurrencyRate.rates)
                let currencyRateArray = currencyRateWithName.map {return $0.value}
                DispatchQueue.main.async {
                    guard self.firstAmountTextField.text != nil  else {return}
                    let amountInDouble = Double(self.firstAmountTextField.text!)
                    self.amountInDouble = amountInDouble!
                    let currencyRate = currencyRateArray.first!
                    self.currencyRate = currencyRate
                }
                
                
                
                
            } catch {
                completed(.failure(CurrencyError.invalidData))
            }
        }
        task.resume()
    }
    
    func getResult() {
        guard self.amountInDouble != nil else {print("have no amount to count")
            return
        }
        guard self.currencyRate != nil else {print ("have no currency rate to count")
            return
        }
        let result = self.amountInDouble! * self.currencyRate!
        DispatchQueue.main.async {
            self.amountLabel.text = String(result)
        }
        
    }
    
    @objc func convertButtonAction () {
        getCurrencyRates(from: baseCurrency, to: secondCurrency) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let _):
                self.getResult()
            case .failure(_):
                return
            }
        }
    }
}
