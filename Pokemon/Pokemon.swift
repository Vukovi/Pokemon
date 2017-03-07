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
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
}
