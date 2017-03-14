//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vuk on 3/5/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit
import Alamofire

class Pokemon {

    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? [String:AnyObject] {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [[String:AnyObject]] , types.count > 0 { //ovaj zarez zamenjuje WHERE iz Swifta 2, a i na jedan i na drugi nacin utvrdjujem da li postoji ovaj niz types
                    if let name = types[0]["name"] as? String {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for i in 1..<types.count {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name.capitalized!)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                if let decriptions = dict["descriptions"] as? [[String:String]] , decriptions.count > 0 {
                    if let url = decriptions[0]["resource_uri"] {
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? [String:AnyObject] {
                                if let description = descDict["description"] as? String {
                                    let newDecription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDecription
                                }
                            }
                            completed()  // IDE I OVDE OBAVEZNO
                        })
                    }
                } else {
                    self._description = ""
                }
                if let evolutions = dict["evolutions"] as? [[String:AnyObject]] , evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil { //HOCU DA NASTAVIM AKO NIJE MEGA, JER SAM GA IZBACIO IZ CSV FAJLA
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }
                
            }
            completed()
        }
    }
}
