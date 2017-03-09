//
//  PokemonDetailVC.swift
//  Pokemon
//
//  Created by Vuk on 3/9/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }


}
