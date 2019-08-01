//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var characterAvatarImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterTypeLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    @IBOutlet weak var characterLocationLabel: UILabel!
    @IBOutlet weak var characterStatusImage: UIImageView!
    @IBOutlet weak var changeCharacterStatusButton: KillButton!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData() {
        navigationBarTitle.title = character?.name
        killCharacterButtonState()
        characterAvatarImage.fetchImageFromString(character?.image ?? "Placeholder.png")
        characterNameLabel.text = character?.name
        characterStatusLabel.text = (character?.status).map { $0.rawValue }
        characterSpeciesLabel.text = (character?.species).map { $0.rawValue }
        characterTypeLabel.text = character?.type
        characterGenderLabel.text = (character?.gender).map { $0.rawValue }
        characterOriginLabel.text = character?.origin.name
        characterLocationLabel.text = character?.location.name
        characterStatusImage.image = (character!.status.rawValue == "Alive") ? Constants.Images.aliveStatusImage : (character!.status.rawValue == "Dead") ? Constants.Images.deadStatusImage : Constants.Images.unknownStatusImage
    }
    
    func killCharacterButtonState() {
        character?.status.rawValue == "Alive" ? changeCharacterStatusButton.killState() : changeCharacterStatusButton.resucitateState()
    }
    

    @IBAction func tapToKill(_ sender: KillButton) {

        let index = Data.currentEpisodeCharacters.firstIndex { (character) -> Bool in
            character.id == self.character?.id
        }
        
        if character?.status.rawValue == "Alive" {
            sender.resucitateState()
            character?.status = .dead
            Data.currentEpisodeCharacters[index!].status = character!.status
            characterStatusImage.image = Constants.Images.deadStatusImage
        } else if character?.status.rawValue != "Alive" || character?.status.rawValue == "unknown" {
            sender.killState()
            character?.status = .alive
            Data.currentEpisodeCharacters[index!].status = character!.status
            characterStatusImage.image = Constants.Images.aliveStatusImage
        }
        
    }

}


