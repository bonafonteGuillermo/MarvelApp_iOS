//
//  DetailViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 31/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var character : Results?
    
    /*@IBOutlet weak var labelCharacterName: UITextView!
    @IBAction func bntAddFavourite(_ sender: Any) {
        addCharacterToFavourite(characterId: (character?.id!)!)
    }*/
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        //labelCharacterName.text = self.character?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
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
