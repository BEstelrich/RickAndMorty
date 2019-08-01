//
//  Constants.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class Constants {
    
    class Design {
        static let cellPadding: CGFloat = 10
        static let cellHeight: CGFloat = 50
    }
    
    class Cells {
        static let episodeCell = "EpisodesCell"
        static let characterCell = "CharactersCell"
    }
    
    class Images {
        static let placeholder = UIImage(imageLiteralResourceName: "Placeholder.png")
        static let aliveStatusImage = UIImage(imageLiteralResourceName: "AliveStatusImage.png")
        static let unknownStatusImage = UIImage(imageLiteralResourceName: "UnknownStatusnImage.png")
        static let deadStatusImage = UIImage(imageLiteralResourceName: "DeadStatusImage.png")
    }
    
    
    class Segues {
        static let episodeCharactersSegue = "EpisodeCharactersSegue"
        static let characterDetailsSegue = "CharacterDetailsSegue"
    }
    
    class Observers {
        static let reloadEpisodesCollectionView = "ReloadEpisodesCollectionView"
    }
    
    class API {
        static var charactersURL: String {
            var charactersNumbers = String()
            
            for number in 1...492 {
                charactersNumbers += "\(number),"
            }
            return "https://rickandmortyapi.com/api/character/\(charactersNumbers)" + "493"
        }
        
        static var episodesURL: String {
            var episodesNumbers = String()
            
            for number in 1...30 {
                episodesNumbers += "\(number),"
            }
            return "https://rickandmortyapi.com/api/episode/\(episodesNumbers)" + "31"
        }
    }
    
}
