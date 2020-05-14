//
//  CoinManager.swift
//  BitcoinConverter
//
//  Created by Claudia Cavalini Maganhi on 12/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBiticoinRate(rate: Double, toCurrency: String)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    let baseUrl: String = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey: String = "0709DEA9-0016-4B9D-9821-0DE87D9C5A87"
    let currencies: [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseUrl)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString)
    }
    
    private func performRequest(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                guard let error = error else { return }
                self.delegate?.didFailWithError(error)
            }
            if let data = data {
                self.parseJson(conversionData: data)
            }
        }
        task.resume()
    }
    
    private func parseJson(conversionData: Data) {
        let decoder = JSONDecoder()
        do {
            let conversionDecodedData = try decoder.decode(CoinData.self, from: conversionData)
            
            delegate?.didUpdateBiticoinRate(rate: conversionDecodedData.rate, toCurrency: conversionDecodedData.asset_id_quote)
            
        } catch let error {
            self.delegate?.didFailWithError(error)
        }
    }
    
}
