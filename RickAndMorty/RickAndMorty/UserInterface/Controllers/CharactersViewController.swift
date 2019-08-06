//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    
    // MARK: - Variables
    var episodeCharacters = [String]()
    var characterIDs = [Int]()
    var episodeTitle = String()
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharactersCollectionView()
        extractCharactersFromEpisodes(episodeCharacters)
        filterCharacters()
        navigationBarTitle.title = episodeTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        charactersCollectionView.reloadData()
    }
    
    
    // MARK: - Local functions
    private func extractCharactersFromEpisodes(_ episodeCharacters: [String]) {
        characterIDs.removeAll()
        for character in episodeCharacters {
            if let index = character.lastIndex(of: "/") {
                let range = character.index(after: index)..<character.endIndex
                let extractedIDString = character[range]
                let integerConversion = Int(extractedIDString)
                characterIDs.append(integerConversion!)
            }
        }
    }
    
    private func filterCharacters() {
        Data.currentEpisodeCharacters = Data.charactersArray.filter({ characterIDs.contains($0.id) })
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.Segues.characterDetailsSegue:
                if let detailsViewController = segue.destination as? DetailsViewController {
                    if let indexPath = self.charactersCollectionView.indexPathsForSelectedItems?.last {
                        detailsViewController.currentCharacter = Data.currentEpisodeCharacters[indexPath.item]
                    }
                }
            default:
                break
            }
        }
    }

}


// MARK: - Extensions
// UIViewController conforming protocols functions.
extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func setupCharactersCollectionView() {
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.currentEpisodeCharacters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.characterCell, for: indexPath) as! CharactersCollectionViewCell
        cell.characterNameLabel.text = Data.currentEpisodeCharacters[indexPath.row].name
        cell.characterImage.fetchImageFromString(Data.currentEpisodeCharacters[indexPath.row].image)
        cell.characterStatusImage.image = (Data.currentEpisodeCharacters[indexPath.row].status.rawValue == "Alive") ? Constants.Images.aliveStatusImage :   (Data.currentEpisodeCharacters[indexPath.row].status.rawValue == "Dead") ? Constants.Images.deadStatusImage : Constants.Images.unknownStatusImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 150)
    }
    
}
