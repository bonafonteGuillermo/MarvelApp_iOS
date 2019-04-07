//
//  DetailViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 31/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

struct Constants {
    static let SECTION_INFO = 0
    static let SECTION_COMIC = 1
    static let SECTION_SERIES = 2
}

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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constants.SECTION_INFO:
            return 1
        case Constants.SECTION_COMIC:
            return (character?.comics?.items?.count)!
        case Constants.SECTION_SERIES:
            return (character?.series?.items?.count)!
       default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Constants.SECTION_INFO:
            let sectionInfoCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            sectionInfoCell.textLabel?.text = self.character?.description
            return sectionInfoCell
        case Constants.SECTION_COMIC:
            //"Section \(indexPath.section)
            let sectionComicCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            sectionComicCell.textLabel?.text = self.character?.comics?.items?[indexPath.row].name
            return sectionComicCell
        case Constants.SECTION_SERIES:
            let sectionSeriesCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            sectionSeriesCell.textLabel?.text = self.character?.series?.items?[indexPath.row].name
            return sectionSeriesCell
        default:
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            defaultCell.textLabel?.text = "-"
            return defaultCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Constants.SECTION_INFO:
            return "Info"
        case Constants.SECTION_COMIC:
            return "Comics"
        case Constants.SECTION_SERIES:
            return "Series"
        default:
            return ""
        }
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
