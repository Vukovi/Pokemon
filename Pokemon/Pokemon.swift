//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vuk on 3/5/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit

class Pokemon {

    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        get {
            return _name
        }
        set {}
    }
    
    var pokedexID: Int {
        get {
            return _pokedexID
        }
        set {}
    }
    
    init(name: String, pokedexID: Int) {
        self.name = name
        self.pokedexID = pokedexID
    }
}
