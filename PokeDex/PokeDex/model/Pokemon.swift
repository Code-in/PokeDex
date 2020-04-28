//
//  Pokemon.swift
//  PokeDex
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation



struct Pokemon : Decodable{
    let name: String
    let id: Int
    let sprites: Sprite
    
    struct Sprite: Decodable {
        let classic: URL
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }
    }
}
