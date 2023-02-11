//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

//By convention, Swift protocols are usually written in the file that has the class/struct which will call the
//delegate methods, i.e. the CoinManager.
protocol CoinManagerDelegate {
    
    //Create the method stubs wihtout implementation in the protocol.
    //It's usually a good idea to also pass along a reference to the current class.
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    //Check the Clima module for more info on this.
    
    //Note: if we want to get a obj we can use a model,else use single data without model
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager{
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate :CoinManagerDelegate?
    
    
    func fetchData(currency:String)  {
        
            let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey!)"
        performRequest(with: urlString, currency: currency)
        
        
    }
    
    
    func performRequest(with urlString: String, currency:String) {
            //1. create a URL
            if let url = URL(string: urlString){
                
                //2. Create a URLSession
                let session = URLSession(configuration: .default)
                
                //3. Give the session a task
                    //Refactored this line to use closure method without declaring a seperate handle function commented below
                    // let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    
                    if let safeData = data {
                        //Format the data we got back as a string to be able to print it.
                        
                        if let bitcoinPrice = self.parseJson(safeData){
                            
                            //Optional: round the price down to 2 decimal places.
                            let priceString = String(format: "%.2f",bitcoinPrice)
                            
                            //Call the delegate method in the delegate (ViewController) and
                            //pass along the necessary data.
                            self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                            
                            //print(bitcoinPrice)
                            
                        }
 
                    }
                    
                }
                
                
                
                //4. Start task to fetch data from bitcoin average's servers.
                task.resume()
                
            }
            
        }
    
    func parseJson(_ data : Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            
            //print(lastPrice)
            
            return lastPrice
        }catch{
            delegate?.didFailWithError(error: error)
            return nil;
        }
    }
        
    
    
    func getCoinPrice(for currency: String) {
        
    }

    
}
