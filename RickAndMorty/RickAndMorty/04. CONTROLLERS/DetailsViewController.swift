//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
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
    
    var character: Character?
    var test = 1
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        performSegue(withIdentifier: "UnwindToCharactersWithSegue", sender: nil)
    }
    
    
    // MARK: - Local functions
    private func populateData() {
        characterAvatarImage.downloadImage(fromURL: character?.image ?? "Placeholder.png")
        characterNameLabel.text = (character?.name == "") ? "N/A" : character?.name
        characterStatusLabel.text = "\(character?.status.rawValue ?? "N/A")"
        characterSpeciesLabel.text = "\(character?.species.rawValue ?? "N/A")"
        characterTypeLabel.text = (character?.type == "") ? "N/A" : character?.type
        characterGenderLabel.text = "\(character?.gender.rawValue ?? "N/A")"
        characterOriginLabel.text = (character?.origin.name == "") ? "N/A" : character?.origin.name
        characterLocationLabel.text = (character?.location.name == "") ? "N/A" : character?.location.name
        characterStatusImage.image = (character!.status.rawValue == "Alive") ? Constants.Images.aliveStatusImage : (character!.status.rawValue == "Dead") ? Constants.Images.deadStatusImage : Constants.Images.unknownStatusImage
        character?.status.rawValue == "Alive" ? changeCharacterStatusButton.killState() : changeCharacterStatusButton.resuscitateState()
    }
    
    
    // MARK: - IBActions
    @IBAction func tapToKill(_ sender: KillButton) {

//        let index = Data.currentEpisodeCharacters.firstIndex { (character) -> Bool in
//            character.id == self.character?.id
//        }
//
        if character?.status.rawValue == "Alive" {
            sender.resuscitateState()
            character?.status = .dead
            characterStatusImage.image = Constants.Images.deadStatusImage
        } else if character?.status.rawValue != "Alive" || character?.status.rawValue == "unknown" {
            sender.killState()
            character?.status = .alive
            characterStatusImage.image = Constants.Images.aliveStatusImage
        }
        
        
    }

}


