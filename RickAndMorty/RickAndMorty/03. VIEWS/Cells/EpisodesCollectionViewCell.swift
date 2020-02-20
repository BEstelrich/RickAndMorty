//
//  EpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    
    
    func populateCell(with episode: Episode) {
        episodeNumberLabel.text = episode.episode
        episodeTitleLabel.text  = episode.name
        episodeDateLabel.text   = episode.airDate
    }
}
