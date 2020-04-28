//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func fetchSpriteAndUpdateUI(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            } // EoDQ
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = pokeSearchBar.text, !searchTerm.isEmpty else { return }
        PokemonController.fetchPokeman(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateUI(for: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            } // EoDQ
        }
    }
}
