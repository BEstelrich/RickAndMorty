//
//  Constants.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class Constants {
    
    /// Design class gathers any design parameter susceptible to be changed in the future.
    public class Design {
        public static let cellPadding: CGFloat = 10
        public static let cellHeight: CGFloat = 50
    }
    
    /// This class recopilates cell identifiers and other related parameters.
    public class Cells {
        public static let episodeCell = "EpisodesCell"
        public static let characterCell = "CharactersCell"
    }
    
    /// Images class is used to give access to the images path.
    public class Images {
        public static let placeholder = UIImage(imageLiteralResourceName: "Placeholder.png")
        public static let aliveStatusImage = UIImage(imageLiteralResourceName: "AliveStatusImage.png")
        public static let unknownStatusImage = UIImage(imageLiteralResourceName: "UnknownStatusnImage.png")
        public static let deadStatusImage = UIImage(imageLiteralResourceName: "DeadStatusImage.png")
    }
    
    /// Segues identifiers are stored in this class.
    public class Segues {
        public static let episodeCharactersSegue = "EpisodeCharactersSegue"
        public static let characterDetailsSegue = "CharacterDetailsSegue"
    }
    
    /// Observers namings are collected in this class.
    public class Observers {
        public static let reloadEpisodesCollectionView = "ReloadEpisodesCollectionView"
    }
    
    /// API strings are gathered here.
    public class API {
        public static var charactersURL: String {
            var charactersNumbers = String()
            
            for number in 1...492 {
                charactersNumbers += "\(number),"
            }
            return "https://rickandmortyapi.com/api/character/\(charactersNumbers)" + "493"
        }
        
        public static var episodesURL: String {
            var episodesNumbers = String()
            
            for number in 1...30 {
                episodesNumbers += "\(number),"
            }
            return "https://rickandmortyapi.com/api/episode/\(episodesNumbers)" + "31"
        }
    }
    
}
