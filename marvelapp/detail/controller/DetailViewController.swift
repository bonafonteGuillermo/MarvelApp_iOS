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
        var myArray = [Int]()
        if let temp = UserDefaults.standard.object(forKey: "myArray") as? [Int] {
            myArray = temp
        }
        myArray.append(characterId)
        UserDefaults.standard.set(myArray, forKey: "myArray")
    }
}
