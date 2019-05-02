//
//  ViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 09/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    
    var characters = [Results?]()
    let repository = RemoteRepository()
    let usersDefaultManager = UsersDefaultManager()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
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
    
    func getCharactersData(){
        SVProgressHUD.show(withStatus: "Loading...")
        self.repository.fetchCharacteres() { (results) in
            self.characters = results!
            DispatchQueue.main.async {
                self.charactersCollectionView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueCharacterDetails", sender: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        let imageUrl : String  = (self.characters[indexPath.row]?.thumbnail?.path)!
        let imageExtension : String  = (self.characters[indexPath.row]?.thumbnail?.thumbnailExtension)!
        let imageFullPath = imageUrl+"."+imageExtension
        
        
        if(usersDefaultManager.isCharacterFavourite(characterId: (self.characters[indexPath.row]?.id)!)){
            cell.characterLikeImageView.image = UIImage(named: "star")
        }else{
            cell.characterLikeImageView.image = nil
        }
        
        cell.characterImageView.contentMode = .scaleAspectFill
        cell.characterImageView.clipsToBounds = false
        
    
        cell.characterImageView.downloaded(from: imageFullPath)
        cell.characterNameLabel.text = self.characters[indexPath.row]?.name
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 200.0, height: 200.0)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 15))/2, height: (collectionView.bounds.width - (3 * 15))/2)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return sectionInset
    }
}
