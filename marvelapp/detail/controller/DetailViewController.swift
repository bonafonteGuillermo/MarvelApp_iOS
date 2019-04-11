//
//  DetailViewController.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 31/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case TYPE_INFO = 0
    case TYPE_COMIC = 1
    case TYPE_SERIES = 2
}

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var character : Results?
    let usersDefaultManager = UsersDefaultManager()
    

    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var navControllerButtonItemText = "Add"
        if(usersDefaultManager.isCharacterFavourite(characterId: (self.character?.id)!)){
            navControllerButtonItemText = "Remove"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: navControllerButtonItemText,
            style: .plain,
            target: self,
            action: #selector(addTapped(sender:))
        )
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        self.navigationItem.title = character?.name
    }
    
    @objc func addTapped(sender : UIBarButtonItem){
        if(sender.title == "Add"){
            usersDefaultManager.addCharacterToFavourite(character: (character)!)
            sender.title = "Remove"
        }else{
            usersDefaultManager.removeCharacterFromFavourite(character: (character)!)
            sender.title = "Add"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SectionType.TYPE_INFO.rawValue:
            return 1
        case SectionType.TYPE_COMIC.rawValue:
            return (character?.comics?.items?.count)!
        case SectionType.TYPE_SERIES.rawValue:
            return (character?.series?.items?.count)!
       default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case SectionType.TYPE_INFO.rawValue:
            let sectionInfoCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            sectionInfoCell.textLabel?.text = self.character?.description
            return sectionInfoCell
        case SectionType.TYPE_COMIC.rawValue:
            //"Section \(indexPath.section)
            let sectionComicCell = tableView.dequeueReusableCell(withIdentifier: "sectionInfoCell", for: indexPath)
            sectionComicCell.textLabel?.text = self.character?.comics?.items?[indexPath.row].name
            return sectionComicCell
        case SectionType.TYPE_SERIES.rawValue:
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
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeaderCell") as! SectionHeaderCell
        
        var imageResourceNamed = String()
        var labelSectionTitle = String()
        
        switch section {
        case SectionType.TYPE_INFO.rawValue:
            imageResourceNamed = "info-icon"
            labelSectionTitle = "MORE INFO"
        case SectionType.TYPE_COMIC.rawValue:
            imageResourceNamed = "comics-icon"
            labelSectionTitle = "COMICS"
        case SectionType.TYPE_SERIES.rawValue:
            imageResourceNamed = "film-icon"
            labelSectionTitle = "SERIES"
        default:
            break
        }
        
        sectionHeaderCell.imageSectionHeader.image = UIImage(named: imageResourceNamed)
        sectionHeaderCell.labelSectionHeader.text = labelSectionTitle
        
        return sectionHeaderCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
