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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var extEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokedexID)")
        
        mainImage.image = image
        currentEvoImage.image = image
        pokedexIDLabel.text = "\(pokemon.pokedexID)"
        
        pokemon.downloadPokemonDetail { //ovaj klozer mi omogucava da dam vrednosti outlet-ima bez pucanja aplikacije, jer zbog samog downloada podataka koji se desava kasnije nego ucitavanje viewDidLoada, ne bih imao sta da dam outlet-ima da sam napsisao samo npr self.typeLabel = type bez klozera
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        baseAttackLabel.text = pokemon.baseAttack
        defenseLabel.text = pokemon.defense
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evoLabel.text = "Nema dalje evolucije."
            extEvoImage.isHidden = true
        } else {
            extEvoImage.isHidden = false
            extEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Sledeća evolucija: \(pokemon.nextEvolutionName) - nivo \(pokemon.nextEvolutionLevel)"
            evoLabel.text = str
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
