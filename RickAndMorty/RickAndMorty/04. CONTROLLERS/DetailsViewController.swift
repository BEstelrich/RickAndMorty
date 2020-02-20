//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IBOutlets and properties.
    var detailsView: CharacterDetailsView! {
        guard isViewLoaded else { return nil }
        return (view as! CharacterDetailsView)
    }
    
    var character: Character?
    
    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.populateView(with: character)
    }
    
    
    // MARK: - IBActions
    @IBAction func tapToKill(_ sender: KillButton) {
        if character?.status.rawValue == "Alive" {
            sender.resuscitateState()
            character?.status = .dead
            detailsView.characterStatusImage.image = Image.deadStatusImage
        } else if character?.status.rawValue != "Alive" || character?.status.rawValue == "unknown" {
            sender.killState()
            character?.status = .alive
            detailsView.characterStatusImage.image = Image.aliveStatusImage
        }
    }

}


