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
    
    
    // MARK: - Variables
    var currentCharacter: Character?
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    
    // MARK: - Local functions
    private func reloadData() {
        characterAvatarImage.fetchImageFromString(currentCharacter?.image ?? "Placeholder.png")
        navigationBarTitle.title = (currentCharacter?.name == "") ? "N/A" : currentCharacter?.name
        characterNameLabel.text = (currentCharacter?.name == "") ? "N/A" : currentCharacter?.name
        characterStatusLabel.text = "\(currentCharacter?.status.rawValue ?? "N/A")"
        characterSpeciesLabel.text = "\(currentCharacter?.species.rawValue ?? "N/A")"
        characterTypeLabel.text = (currentCharacter?.type == "") ? "N/A" : currentCharacter?.type
        characterGenderLabel.text = "\(currentCharacter?.gender.rawValue ?? "N/A")"
        characterOriginLabel.text = (currentCharacter?.origin.name == "") ? "N/A" : currentCharacter?.origin.name
        characterLocationLabel.text = (currentCharacter?.location.name == "") ? "N/A" : currentCharacter?.location.name
        characterStatusImage.image = (currentCharacter!.status.rawValue == "Alive") ? Constants.Images.aliveStatusImage : (currentCharacter!.status.rawValue == "Dead") ? Constants.Images.deadStatusImage : Constants.Images.unknownStatusImage
        currentCharacter?.status.rawValue == "Alive" ? changeCharacterStatusButton.killState() : changeCharacterStatusButton.resuscitateState()
    }
    
    
    // MARK: - IBActions
    @IBAction func tapToKill(_ sender: KillButton) {

        let index = Data.currentEpisodeCharacters.firstIndex { (character) -> Bool in
            character.id == self.currentCharacter?.id
        }
        
        if currentCharacter?.status.rawValue == "Alive" {
            sender.resuscitateState()
            currentCharacter?.status = .dead
            Data.currentEpisodeCharacters[index!].status = currentCharacter!.status
            characterStatusImage.image = Constants.Images.deadStatusImage
        } else if currentCharacter?.status.rawValue != "Alive" || currentCharacter?.status.rawValue == "unknown" {
            sender.killState()
            currentCharacter?.status = .alive
            Data.currentEpisodeCharacters[index!].status = currentCharacter!.status
            characterStatusImage.image = Constants.Images.aliveStatusImage
        }
        
    }

}


