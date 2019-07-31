//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    var characters = [String]()
    var characterIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharactersCollectionView()
        // Do any additional setup after loading the view.
        print(characters)
        parseCharaters(characters: characters)
        filterCharacters()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.Segues.characterDetailsSegue:
                if let detailsViewController = segue.destination as? DetailsViewController {
                    if let indexPath = self.charactersCollectionView.indexPathsForSelectedItems?.last {
                        detailsViewController.character = Data.charactersArray[indexPath.item]
                    }
                }
            default:
                break
            }
        }
    }
    
    func parseCharaters(characters: [String]) -> [Int] {
        characterIDs.removeAll()
        for character in characters {
            let initialIndex = character.index(character.startIndex, offsetBy: 42)
            let extractedString = character[initialIndex...]
            let integerConversion = Int(extractedString)
            characterIDs.append(integerConversion!)
        }
        print(characterIDs)
        return characterIDs
    }
    
    func filterCharacters() {
        Data.currentEpisodeCharacters = Data.charactersArray.filter({ characterIDs.contains($0.id) })
    }

}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupCharactersCollectionView() {
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.currentEpisodeCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.characterCell, for: indexPath) as! CharactersCollectionViewCell
        cell.characterNameLabel.text = Data.currentEpisodeCharacters[indexPath.row].name
        cell.characterImage.imageFromServerURL(urlString: Data.currentEpisodeCharacters[indexPath.row].image)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 10
//        if UIDevice.current.userInterfaceIdiom == .phone  {
//            return CGSize(width: (UIScreen.main.bounds.width - padding)/2, height: 50)
//        } else if UIDevice.current.userInterfaceIdiom == .pad {
//            if UIApplication.shared.statusBarOrientation.isPortrait {
//                return CGSize(width: (UIScreen.main.bounds.width - padding)/2, height: 50)
//            } else {
//                return CGSize(width: (UIScreen.main.bounds.width - padding)/3, height: 50)
//            }
//        }
        
        return CGSize(width: 125, height: 150)
    }
    
}
