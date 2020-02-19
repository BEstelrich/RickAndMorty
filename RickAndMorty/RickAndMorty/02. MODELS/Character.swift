//
//  Character.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

struct Character: Codable {
    
    let id: Int
    let name: String
    var status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    
    enum Status: String, Codable {
        case alive   = "Alive"
        case dead    = "Dead"
        case unknown = "unknown"
    }
    
    
    enum Species: String, Codable {
        case alien         = "Alien"
        case animal        = "Animal"
        case cronenberg    = "Cronenberg"
        case disease       = "Disease"
        case human         = "Human"
        case humanoid      = "Humanoid"
        case mytholog      = "Mytholog"
        case parasite      = "Parasite"
        case poopyButThole = "Poopybutthole"
        case robot         = "Robot"
        case unknown       = "unknown"
        case vampire       = "Vampire"
    }
    
    
    enum Gender: String, Codable {
        case female     = "Female"
        case genderless = "Genderless"
        case male       = "Male"
        case unknown    = "unknown"
    }
    
    
    struct Location: Codable {
        let name: String
        let url: String
    }
    
}









