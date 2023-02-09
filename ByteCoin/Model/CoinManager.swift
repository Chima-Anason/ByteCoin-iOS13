//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func fetchData(for currency:String)  {
        
            let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey!)"
            performRequest(with: urlString)
        
        
    }
    
    
    func performRequest(with urlString: String) {
            //1. create a URL
            if let url = URL(string: urlString){
                
                //2. Create a URLSession
                let session = URLSession(configuration: .default)
                
                //3. Give the session a task
                    //Refactored this line to use closure method without declaring a seperate handle function commented below
                    // let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        //self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        //Format the data we got back as a string to be able to print it.
                        let dataString = String(data: safeData, encoding: .utf8)
                        print(dataString!)
 
                    }
                }
                
                
                
                //4. Start task to fetch data from bitcoin average's servers.
                task.resume()
                
            }
            
        }
        
    
    
    func getCoinPrice(for currency: String) {
        
    }

    
}
