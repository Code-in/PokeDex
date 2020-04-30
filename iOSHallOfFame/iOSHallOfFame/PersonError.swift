//
//  PersonError.swift
//  iOSHallOfFame
//
//  Created by Pete Parks on 4/29/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation


enum PersonError: LocalizedError {
    case invalidURL
    case thrown(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "unable to reach DevMountain"
        case .thrown(let error):
            return error.localizedDescription
        case .noData:
            return "Server return no data"
        }
    }
}


