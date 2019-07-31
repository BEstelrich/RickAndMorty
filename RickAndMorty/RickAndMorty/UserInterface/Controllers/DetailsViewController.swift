//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var characterAvatarImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterTypeLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    @IBOutlet weak var characterLocationLabel: UILabel!
    
    var character: Characters?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCharacterData()
    }
    
    func displayCharacterData() {
        characterAvatarImage.imageFromServerURL(urlString: character!.image)
        characterNameLabel.text = character?.name
        characterStatusLabel.text = (character?.status).map { $0.rawValue }
        characterSpeciesLabel.text = (character?.species).map { $0.rawValue }
        characterTypeLabel.text = character?.type
        characterGenderLabel.text = (character?.gender).map { $0.rawValue }
        characterOriginLabel.text = character?.origin.name
        characterLocationLabel.text = character?.location.name
    }

    @IBAction func tapToKill(_ sender: UIButton) {
    }
}
