//
//  ViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

// MARK: - 1. VIEWCONTROLLER
class EpisodesViewController: UIViewController  {
    
    // MARK: - IBOutlets and properties.
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    
    var episodes: [Episode]      = [] { didSet { DispatchQueue.main.async { self.episodesCollectionView.reloadData() } } }
    var characters: [Character]  = []
    
    var isLoading: Bool          = false
    var charactersCount: Int     = 0
    var episodesCurrentPage: Int = 1
    var episodesTotalPages: Int!
    
    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodesCollectionView()
        fetchEpisodesAndCharacters()
    }
    
    
    @IBAction func unwindToEpisodes(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? CharactersViewController {
            let sourceCharacters = sourceViewController.characters
            for character in characters {
                for sourceCharacter in sourceCharacters {
                    if character.id == sourceCharacter.id {
                        character.status = sourceCharacter.status
                    }
                }
            }
        }
    }
    
    
    // MARK: - Local methods.
    private func fetchEpisodesAndCharacters() {
        isLoading = true
        
        NetworkManager.shared.getEpisodes(for: episodesCurrentPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episodesData):
                self.episodesTotalPages = episodesData.info.pages
                episodesData.results.forEach { self.episodes.append($0) }
                self.fetchCharactersCount()
                
            case .failure(let error):
                print(error)
                self.presentAlertOnMainThread(CustomAlert.showEpisodesErrorAlert)
            }
            self.isLoading = false
        }
    }
    
    
    private func fetchCharactersCount() {
        NetworkManager.shared.getCharactersCount { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let charactersData):
                self.charactersCount = charactersData.info.count
                self.fetchAllCharacters()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func fetchAllCharacters() {
        guard characters.isEmpty else { return }
        
        var charactersID: [Int] = []
        charactersID.append(contentsOf: 1...charactersCount)
        
        let charactersIDString: String = charactersID.map { String($0) }.joined(separator: ",")
        
        NetworkManager.shared.getCharacters(from: charactersIDString) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let characters):
                self.characters = characters
           
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func filterEpisodeCharacters(for characterStringsArray: [String]) -> [Character] {
        var charactersID: [Int] = []
        var filteredCharacters: [Character] = []
        
        for characterStrings in characterStringsArray {
            if let index = characterStrings.lastIndex(of: "/") {
                let stringID    = characterStrings[characterStrings.index(after: index)...]
                let integerID   = Int(stringID) ?? 0
                charactersID.append(integerID)
            }
        }
        
        filteredCharacters = characters.filter { charactersID.contains($0.id) }
        
        return filteredCharacters
    }
    
    
    // MARK: - Segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let charactersViewController = segue.destination as? CharactersViewController {
            if let cell = sender as? EpisodesCollectionViewCell,
              let indexPath = self.episodesCollectionView.indexPath(for: cell) {
                charactersViewController.characters           = filterEpisodeCharacters(for: episodes[indexPath.row].characters)
                charactersViewController.navigationItem.title = episodes[indexPath.row].episode
            }
        }
    }

}


// MARK: - 2. PROTOCOLS
// UIViewController conforming protocols functions.
extension EpisodesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupEpisodesCollectionView() {
        episodesCollectionView.delegate   = self
        episodesCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.episodeCell, for: indexPath) as! EpisodesCollectionViewCell
        cell.populateCell(with: episodes[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let saveAreaWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        let cellSetup     = UserInterfaceHelper.setCell(width: saveAreaWidth, height: Design.cellHeight, padding: Design.cellPadding)
        return cellSetup
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard !isLoading,
            episodesCurrentPage < episodesTotalPages else { return }

            episodesCurrentPage += 1
            fetchEpisodesAndCharacters()
        }
    }

}
