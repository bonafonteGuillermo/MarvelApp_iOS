//
//  DetailViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 31/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var character : Results?
    
    @IBOutlet weak var labelCharacterName: UITextView!
    @IBAction func bntAddFavourite(_ sender: Any) {
        addCharacterToFavourite(characterId: (character?.id!)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCharacterName.text = self.character?.name
    }
    
    func addCharacterToFavourite(characterId : Int){
        UserDefaults.standard.set(characterId, forKey: "favouritesCharacters")
    }
}
