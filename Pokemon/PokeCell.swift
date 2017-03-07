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
    
    required init?(coder aDecoder: NSCoder) { //ovim se upravlja view-em na nivou layer-a
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
    
        self.pokemon = pokemon
        
        self.nameLbl.text = self.pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
    
}
