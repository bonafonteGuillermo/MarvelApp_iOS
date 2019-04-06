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
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    
    var characters = [Results?]()
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        
        getCharactersData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.charactersCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController{
            let rowSelected = (sender as! NSIndexPath).row
            detailViewController.character = self.characters[rowSelected]
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueCharacterDetails", sender: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        let imageUrl : String  = (self.characters[indexPath.row]?.thumbnail?.path)!
        let imageExtension : String  = (self.characters[indexPath.row]?.thumbnail?.thumbnailExtension)!
        let imageFullPath = imageUrl+"."+imageExtension
        
        var myArray = [Int]()
        if let temp = UserDefaults.standard.object(forKey: "myArray") as? [Int] {
            myArray = temp
        }
        
        if(myArray.contains((self.characters[indexPath.row]?.id)!)){
            cell.characterLikeImageView.image = UIImage(named: "like")
        }else{
            cell.characterLikeImageView.image = nil
        }
        
        cell.characterImageView.downloaded(from: imageFullPath)
        cell.characterNameLabel.text = self.characters[indexPath.row]?.name
        
        return cell
    }
    
    func getCharactersData(){
        fetchCharacteres() { (results) in
            for result in results! {
                self.characters = results!
                DispatchQueue.main.async {
                    self.charactersCollectionView.reloadData()
                }
            }
        }
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
