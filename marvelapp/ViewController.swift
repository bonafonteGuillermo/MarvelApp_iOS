//
//  ViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 09/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit
import CommonCrypto

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apikey = "081c9bb85caaf1c502810fa48e08403c"
        let privateKey = "052136959b724188c1892cddd1341d1c78d85704"
        let timeStamp = "1"
        let hash = (timeStamp+privateKey+apikey).md5()
        
        let baseUrl = URL(string : "https://gateway.marvel.com:443/v1/public/characters?")!
        
        let query: [String: String] = [
            "ts" : timeStamp,
            "apikey": apikey,
            "hash": hash
        ]
        
          
        let fullUrl = baseUrl.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(Response.self, from: dataResponse)

                print(model)

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
