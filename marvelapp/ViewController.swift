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
        let hash = md5(timeStamp+privateKey+apikey)
        
        let baseUrl = URL(string : "https://gateway.marvel.com:443/v1/public/characters?")!
        
        let query: [String: String] = [ "hash": hash, "apikey": apikey, "ts" : timeStamp ]
        
          
        let fullUrl = baseUrl.withQueries(query)!
        
        print(fullUrl)
        
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
    
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}



