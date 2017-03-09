//
//  ViewController.swift
//  Pokemon
//
//  Created by Vuk on 3/5/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done //sklanja mi se tastarura kad na njoj stisnem RETURN
        
        parsePokemonCSV()
        initAudio()
    }
    
    func parsePokemonCSV() {
    
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")! //pokupio sam excel fajl
        do {
            let csv = try CSV(contentsOfURL: path) //parsiram excel fajl pomocu CSV biblioteke koju sam ubacio
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemons.append(poke)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "mp3")
        do {
            let url = URL(string: path!)
            musicPlayer = try AVAudioPlayer(contentsOf: url!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //ovo znaci da ce non stop da se vrti muzika
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
        
            //let pokemon = Pokemon(name: "Pokemon", pokedexID: indexPath.row)
            //let pokemon = pokemons[indexPath.row]
            //cell.configureCell(pokemon: pokemon)
            //return cell
            
            var poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            } else {
                poke = pokemons[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // segue je napravljen tako da ide od viewControllera ka pokemonDetailVC, a ne od celije ka pokemonDetailVC jer se tako ne bi premeneli svi podaci koji ce nam biti potrebi u pokemonDetailVC -u
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVCSegue", sender: poke) //poke saljem segue-jem pokemonDeatilVC-u, i ovde se konacno izvodi slanje informacije koja je pripremljna u f-ji preprareForSegue
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105) // kao one u storyboardu
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true) //ovim sklanjam tastaturu, sl. kao resignFirstResponser, kad izbrisem teks backspaceom do kraja
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemons.filter({ (pokemon) -> Bool in
                pokemon.name.range(of: lower) != nil
            })
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) //takodje zbog sklanjanja tastature
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVCSegue" { //ako je segue bas ovaj koji se navodi, onda
            if let pokemonDetailVC = segue.destination as? PokemonDetailVC { //napravi objekat zeljene destinacije koristeci segue, a zatim,
                if let poke = sender as? Pokemon { // daj oblik elementu koji saljes, u ovom sl. oblik je Pokemon
                    pokemonDetailVC.pokemon = poke // i postavi taj element za slanje kao vrednost promenljive koja se nalazi u klasi koja treba da dobije posiljku
                }
            }
        }
    }
    
}

