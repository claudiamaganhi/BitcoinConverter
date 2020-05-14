//
//  CoinData.swift
//  BitcoinConverter
//
//  Created by Claudia Cavalini Maganhi on 12/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
