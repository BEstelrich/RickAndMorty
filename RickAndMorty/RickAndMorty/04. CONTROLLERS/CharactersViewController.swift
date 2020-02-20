//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

// MARK: - 1. VIEWCONTROLLER
class CharactersViewController: UIViewController {
    
    // MARK: - IBOutlets and properties.
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var characters: [Character] = []
    
    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharactersCollectionView()
    }
    
    
    @IBAction func unwindToCharacters(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? DetailsViewController {
            let sourceCharacter = sourceViewController.character
            characters.filter { $0.id == sourceCharacter!.id }.first?.status = sourceCharacter!.status
            DispatchQueue.main.async { self.charactersCollectionView.reloadData() }
        }
    }
    
    
    // MARK: - Segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {
            if let cell = sender as? CharactersCollectionViewCell,
              let indexPath = self.charactersCollectionView.indexPath(for: cell) {
                detailsViewController.character            = characters[indexPath.row]
                detailsViewController.navigationItem.title = characters[indexPath.row].name
            }
        }
    }

}


// MARK: - 2. PROTOCOLS
// UIViewController conforming protocols functions.
extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCharactersCollectionView() {
        charactersCollectionView.delegate   = self
        charactersCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.characterCell, for: indexPath) as! CharactersCollectionViewCell
        cell.populateCell(with: characters[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 150)
    }
    
}
