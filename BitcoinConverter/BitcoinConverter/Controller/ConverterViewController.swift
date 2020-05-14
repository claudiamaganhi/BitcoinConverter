//
//  ViewController.swift
//  BitcoinConverter
//
//  Created by Claudia Cavalini Maganhi on 12/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var bitcoinImageView: UIImageView!
    @IBOutlet weak var rateContainerView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        setDelegatesAndDataSource()
    }
    
    private func applyStyle() {
        bitcoinImageView.clipsToBounds = true
        bitcoinImageView.layer.cornerRadius = bitcoinImageView.layer.frame.size.width / 2
        rateContainerView.clipsToBounds = true
        rateContainerView.layer.cornerRadius = 10
    }
    
    private func setDelegatesAndDataSource() {
        coinManager.delegate = self
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
    }
    
    private func presentErrorAlert(error: Error) {
        let nserror = error as NSError
        let alert = UIAlertController(title: "Somenthing went wrong", message: "error code: \(nserror.code)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        
       present(alert, animated: true)
    }
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencies[row])
    }
    
}


extension ConverterViewController: CoinManagerDelegate {
    func didUpdateBiticoinRate(rate: Double, toCurrency: String) {
        let formattedRate = String(format: "%.2f", rate)
        DispatchQueue.main.async {
            self.rateLabel.text = "\(formattedRate) \(toCurrency)"
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.presentErrorAlert(error: error)
        }
    }
    
    
}
