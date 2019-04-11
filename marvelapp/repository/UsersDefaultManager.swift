//
//  UsersDefaultManager.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 11/04/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import Foundation

class UsersDefaultManager {
    func isCharacterFavourite(characterId : Int) -> Bool{
        var myArray = [String]()
        if let temp = UserDefaults.standard.object(forKey: "myArray") as? [String] {
            myArray = temp
        }
        
        var charactersArray = [Results]()
        for stringCharacter in myArray{
            let jsonData = stringCharacter.data(using: String.Encoding.utf8)!
            let decoder = JSONDecoder()
            guard let character =
                try? decoder.decode(Results.self, from: jsonData)
                else { break }
            charactersArray.append(character)
        }
        
        if charactersArray.contains(where: { $0.id == characterId }) {
            return true
        }else{
            return false
        }
    }
    
    func addCharacterToFavourite(character : Results){
        
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(character) else{ return }
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        var myArray = [String]()
        if let temp = UserDefaults.standard.object(forKey: "myArray") as? [String] {
            myArray = temp
        }
        myArray.append(json!)
        UserDefaults.standard.set(myArray, forKey: "myArray")
    }
    
    func removeCharacterFromFavourite(character : Results){
        
        var myArray = [String]()
        if let temp = UserDefaults.standard.object(forKey: "myArray") as? [String] {
            myArray = temp
        }
        
        var charactersArray = [Results]()
        for stringCharacter in myArray{
            let jsonData = stringCharacter.data(using: String.Encoding.utf8)!
            let decoder = JSONDecoder()
            guard let character =
                try? decoder.decode(Results.self, from: jsonData)
                else { break }
            charactersArray.append(character)
        }
        
        if let index = charactersArray.index(where: { $0.id == character.id}){
            charactersArray.remove(at: index)
        }
        
        var newArray = [String]()
        let encoder = JSONEncoder()
        for characterItem in charactersArray{
            guard let jsonData = try? encoder.encode(characterItem) else{ return }
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            newArray.append(json!)
        }
        
        myArray = newArray
        UserDefaults.standard.set(myArray, forKey: "myArray")
    }
}
