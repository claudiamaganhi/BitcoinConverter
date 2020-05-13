//
//  ViewController.swift
//  BitcoinConverter
//
//  Created by Claudia Cavalini Maganhi on 12/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinImageView: UIImageView!
    @IBOutlet weak var rateContainerView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyPicerView: UIPickerView!
    
    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
        currencyPicerView.delegate = self
        currencyPicerView.dataSource = self
        
        coinManager.fetchConversion("USD")
    }
    
    private func applyStyle() {
        bitcoinImageView.clipsToBounds = true
        bitcoinImageView.layer.cornerRadius = bitcoinImageView.layer.frame.size.width / 2
        rateContainerView.clipsToBounds = true
        rateContainerView.layer.cornerRadius = 10
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
}

