//
//  FavouritesViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 10/04/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

class FavouritesViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    
    let usersDefaultManager = UsersDefaultManager()
    var favourites = [Results]()
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
        
        self.favourites = self.usersDefaultManager.getFavourites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favourites = self.usersDefaultManager.getFavourites()
        self.favouritesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as! FavouriteCell
        
        let imageUrl : String  = (self.favourites[indexPath.row].thumbnail?.path)!
        let imageExtension : String  = (self.favourites[indexPath.row].thumbnail?.thumbnailExtension)!
        let imageFullPath = imageUrl+"."+imageExtension
        
        cell.favouriteImage.setRounded()
        cell.favouriteImage.downloaded(from: imageFullPath)
        cell.favouriteLabel.text = self.favourites[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
        return CGSize(width: UIScreen.main.bounds.width, height: 90.0)
     }
}
