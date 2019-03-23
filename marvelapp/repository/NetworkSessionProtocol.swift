//
//  NetworkSession.swift
//  marvelapp
//
//  Created by Guillermo Bonafonte Criado on 23/03/2019.
//  Copyright © 2019 Guillermo Bonafonte Criado. All rights reserved.
//

import Foundation
import MapKit

protocol NetworkSessionProtocol {
    func fetchCharacteres(completionHandler: @escaping ([Results]?) -> Void)
}
