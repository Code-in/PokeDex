//
//  Person.swift
//  iOSHallOfFame
//
//  Created by Pete Parks on 4/29/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation


struct Like: Codable {
    let text: String
    enum CodingKeys: String, CodingKey {
        case text = "likes_text"
    }
}


struct Dislike: Codable {
    let text: String
    enum CodingKeys: String, CodingKey {
        case text = "dislikes_text"
    }
}

struct Person: Codable {
    let firstName: String
    let lastName: String
    let cohort: String
    let id: Int?
    let likes: [Like]?
    let dislikes: [Dislike]?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case cohort
        case id = "person_id"
        case likes
        case dislikes
    }
}


// return
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.cohort == rhs.cohort
    }
}

