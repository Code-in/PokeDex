//
//  PokemonError.swift
//  PokeDex
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

enum PokemonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "Ther server responded with bad data"
        }
    }
}
