//
//  CoinModel.swift
//  ByteCoin
//
//  Created by mac on 11/02/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let coinRate: Double
    
    var coinRateString:String {
        return String(format: "%.1f",coinRate)
    }
}
