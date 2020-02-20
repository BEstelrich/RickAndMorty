//
//  Constants.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-31.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

enum Design {
    static let cellPadding: CGFloat       = 10
    static let cellHeight: CGFloat        = 50
}


enum Image {
    static let placeholder                = UIImage(imageLiteralResourceName: "Placeholder.png")
    static let aliveStatusImage           = UIImage(imageLiteralResourceName: "AliveStatusImage.png")
    static let unknownStatusImage         = UIImage(imageLiteralResourceName: "UnknownStatusnImage.png")
    static let deadStatusImage            = UIImage(imageLiteralResourceName: "DeadStatusImage.png")
}


enum Identifier {
    
    enum Segue {
        static let episodeCharactersSegue = "EpisodeCharactersSegue"
        static let characterDetailsSegue  = "CharacterDetailsSegue"
    }
    
    
    enum Cell {
        static let episodeCell            = "EpisodesCell"
        static let characterCell          = "CharactersCell"
    }
    
}


enum CustomAlert {
    static let showEpisodesErrorAlert     = Alert(title: "No episodes error",
                                                  message: "There is no episodes to show. Please try again.",
                                                  buttonTitle: "OK")
    
    static let showCharactersErrorAlert   = Alert(title: "No characters error",
                                                  message: "There is no characters to show. Please try again.",
                                                  buttonTitle: "OK")
}
