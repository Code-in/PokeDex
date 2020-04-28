//
//  PokemonController.swift
//  PokeDex
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    static func fetchPokeman(searchTerm: String, completion: @escaping(Result<Pokemon, PokemonError>) -> Void) {
        guard let baseURL = self.baseURL else { return completion(.failure(.invalidURL)) }
        let finalURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch let decodingError {
                return completion(.failure(.thrownError(decodingError)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping(Result<UIImage, PokemonError>) -> Void) {
        let spriteURL = pokemon.sprites.classic
        
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
            
        }.resume()
    }
    
}
