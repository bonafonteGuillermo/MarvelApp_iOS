//
//  ViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 09/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=081c9bb85caaf1c502810fa48e08403c")!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in if let data = data {
                print(data)
            }
        }
        
        task.resume()
    }


}

