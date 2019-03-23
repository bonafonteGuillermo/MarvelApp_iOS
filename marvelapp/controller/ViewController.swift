//
//  ViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 09/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

class ViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate
{
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var characterNames : Array<String?> = ["juan", "pepe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        
        fetchCharacteres() { (results) in
            for result in results! {
                print(result.name)
                self.characterNames.append(result.name) //NOT WORKING
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.characterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        cell.characterNameLabel.text = self.characterNames[indexPath.row]
        return cell
    }
    
    func fetchCharacteres(completionHandler: @escaping ([Results]?) -> Void){
        
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
        URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { print("Error, no data retrieved"); return }
            guard let charactersResponse =
                try? decoder.decode(Response.self, from: data)
                else{
                    print("Error, could not parse data");
                    completionHandler(nil);
                    return
            }
            completionHandler(charactersResponse.data?.results)
            }.resume()
    }
}