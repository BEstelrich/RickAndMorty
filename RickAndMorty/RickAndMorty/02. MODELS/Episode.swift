//
//  Episodes.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation


struct EpisodesData: Codable {
    
    let info: Info
    let results: [Episode]
    
}


struct Info: Codable {
    
    let count: Int
    let pages: Int
    
}


struct Episode: Codable {
    
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
    
}
