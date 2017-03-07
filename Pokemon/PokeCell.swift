//
//  PokeCell.swift
//  Pokemon
//
//  Created by Vuk on 3/7/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
    
        self.pokemon = pokemon
        
        self.nameLbl.text = self.pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
    
}
