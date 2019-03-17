//
//  ViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 09/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit
import CommonCrypto

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("T##items: Any...##Anydklgjdklgjfl")
        /*let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=081c9bb85caaf1c502810fa48e08403c")!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
            }
            if let data = data {
                print(data)
            }
        }
        
        task.resume()*/
        
        
        let md5String = md5("Hello, I am a hashed md5 string")
        print(md5String)
        
        
        
        
        
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

