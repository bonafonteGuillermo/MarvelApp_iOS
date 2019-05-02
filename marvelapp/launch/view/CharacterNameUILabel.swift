//
//  CharacterNameUILabel.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 02/05/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import Foundation
import UIKit

class CharacterNameUILabel : UILabel{
    
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
        self.font = UIFont.boldSystemFont(ofSize: 18.0)
        super.drawText(in: rect.inset(by : inset))
    }

}
