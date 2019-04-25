//
//  RemoteRepository.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 23/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import Foundation

class RemoteRepository {
    
    let apikey = "081c9bb85caaf1c502810fa48e08403c"
    let privateKey = "052136959b724188c1892cddd1341d1c78d85704"
    let timeStamp = "1"
    let limit = "100"
    lazy var hash = (timeStamp+privateKey+apikey).md5()
    lazy var query: [String: String] = [
        "limit" : limit,
        "ts" : timeStamp,
        "apikey": apikey,
        "hash": hash
    ]
    
    func fetchCharacteres(completionHandler: @escaping ([Results]?) -> Void){
        
        let baseUrl = URL(string : "https://gateway.marvel.com:443/v1/public/characters?")!
        
        let fullUrl = baseUrl.withQueries(query)!
        URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { print("Error, no data retrieved"); return }
            guard let charactersResponse =
                try? decoder.decode(Response.self, from: data)
                else{
                    print("Error, could not parse data")
                    completionHandler(nil)
                    return
            }
            completionHandler(charactersResponse.data?.results)
            }.resume()
    }
}
