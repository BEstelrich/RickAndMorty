//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by BES on 2020-02-20.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import UIKit

class CharacterDetailsView: UIView {
    
    @IBOutlet weak var characterAvatarImage: CharacterImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterTypeLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    @IBOutlet weak var characterLocationLabel: UILabel!
    @IBOutlet weak var characterStatusImage: UIImageView!
    @IBOutlet weak var changeCharacterStatusButton: KillButton!
    
    
    func populateView(with character: Character?) {
        characterNameLabel.text     = character?.name.isEmpty == true ? "N/A" : character?.name
        characterStatusLabel.text   = character?.status.rawValue ?? "N/A"
        characterSpeciesLabel.text  = character?.species.rawValue ?? "N/A"
        characterTypeLabel.text     = character?.type.isEmpty == true ? "N/A" : character?.type
        characterGenderLabel.text   = character?.gender.rawValue ?? "N/A"
        characterOriginLabel.text   = character?.origin.name.isEmpty == true ? "N/A" : character?.origin.name
        characterLocationLabel.text = character?.location.name.isEmpty == true ? "N/A" : character?.location.name
        characterStatusImage.image  = character?.status.rawValue == "Alive" ? Image.aliveStatusImage : character?.status.rawValue == "Dead"
            ? Image.deadStatusImage : Image.unknownStatusImage
        characterAvatarImage.downloadImage(fromURL: character?.image ?? "Placeholder.png")
        character?.status.rawValue == "Alive" ? changeCharacterStatusButton.killState() : changeCharacterStatusButton.resuscitateState()
    }
    
}
