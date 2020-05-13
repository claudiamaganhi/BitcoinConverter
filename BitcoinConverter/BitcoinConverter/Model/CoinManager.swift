//
//  CoinManager.swift
//  BitcoinConverter
//
//  Created by Claudia Cavalini Maganhi on 12/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import Foundation

struct CoinManager {
    let baseUrl: String = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey: String = "0709DEA9-0016-4B9D-9821-0DE87D9C5A87"
    
    func fetchConversion(_ currency: String) {
        let urlString = "\(baseUrl)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        performRequest(urlString)
    }
    
    private func performRequest(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                //handle error
            }
            if let data = data {
                self.parseJson(conversionData: data)
            }
        }
        task.resume()
    }
    
    private func parseJson(conversionData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let conversionDecodedData = try decoder.decode(CoinData.self, from: conversionData)
            let date = conversionDecodedData.time
            let fromCurrency = conversionDecodedData.asset_id_base
            let toCurrency = conversionDecodedData.asset_id_quote
            let rate = conversionDecodedData.rate
            
            let conversion = CoinModel(timeOfConversion: date, fromCurrency: fromCurrency, toCurrency: toCurrency, rate: rate)
            
            return conversion
            
        } catch let error {
            //handle error
            print(error)
            return nil
        }
    }
    
}
