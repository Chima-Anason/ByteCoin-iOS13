//
//  CoinData.swift
//  ByteCoin
//
//  Created by mac on 11/02/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation


//Make the struct conform to the Decodable protocol to use it to decode our JSON.
//NOTE: You can also use the Codable type alias to conform to both Decodable and Encodable protocls in case you
//want to turn a Swift object back into a JSON.
struct CoinData : Codable {
    
    //There's only 1 property we're interested in the JSON data, that's the last price of bitcoin
    //Because it's a decimal number, we'll give it a Double data type.
    let rate : Double
}
