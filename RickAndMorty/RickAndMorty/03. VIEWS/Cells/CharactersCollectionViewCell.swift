//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: CharacterImageView!
    @IBOutlet weak var characterStatusImage: UIImageView!
    
    
    func populateCell(with character: Character) {
        characterNameLabel.text    = character.name
        characterStatusImage.image = character.status.rawValue == "Alive" ? Image.aliveStatusImage : character.status.rawValue == "Dead" ? Image.deadStatusImage : Image.unknownStatusImage
        characterImage.downloadImage(fromURL: character.image)
    }
}
