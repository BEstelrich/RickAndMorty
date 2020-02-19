//
//  ViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController  {
    
    // MARK: - IBOutlets
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    
    var episodes: [Episode] = [] { didSet { DispatchQueue.main.async { self.episodesCollectionView.reloadData() } } }
    var characters: [Character] = []
    
    var charactersCount: Int = 0
    
    var isLoading: Bool            = false
    var episodesCurrentPage: Int   = 1
    var episodesTotalPages: Int!
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodesCollectionView()
        getCharacterCount()
        fetchEpisodes(for: episodesCurrentPage)
    }
    
    @IBAction func unwindToEpisodes(segue: UIStoryboardSegue) {
//        if let sourceViewController = segue.source as? CharactersViewController {
//            let sourceCharacter = sourceViewController.
//            characters.filter { $0.id == sourceCharacter!.id }.first?.status = sourceCharacter!.status
//            DispatchQueue.main.async { self.charactersCollectionView.reloadData() }
//        }
    }
    
    
    // MARK: - Local functions
    private func fetchEpisodes(for page: Int) {
        isLoading = true
        
        NetworkManager.shared.getEpisodes(for: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episodesData):
                self.episodesTotalPages = episodesData.info.pages
                episodesData.results.forEach { self.episodes.append($0) }
                
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
    
    
    private func getCharacterCount() {
        NetworkManager.shared.getCharactersCount { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let charactersData):
                self.charactersCount = charactersData.info.count
                print(self.charactersCount)
                self.fetchAllCharacters()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func fetchAllCharacters() {
        var charactersNumbers: String = "1"
        
        for number in 2...charactersCount {
            charactersNumbers += ",\(number)"
        }

        NetworkManager.shared.getCharacters(from: charactersNumbers) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.characters = characters
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func filterCharacters(by episodeIndex: Int) -> [Character] {
        let selectedEpisode = episodes.filter { $0.id == episodeIndex }.first
        let charactersIDs   = selectedEpisode?.characters
        
//        let ids = charactersIDs?.inde
        
        return [Character]()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let charactersViewController = segue.destination as? CharactersViewController {
            if let cell = sender as? EpisodesCollectionViewCell,
              let indexPath = self.episodesCollectionView.indexPath(for: cell) {
                print(episodes[indexPath.row])
//                charactersViewController.characters           = episodes[indexPath.row].characters
                charactersViewController.navigationItem.title = episodes[indexPath.row].episode
            }
        }
    }

}


// MARK: - Extensions
// UIViewController conforming protocols functions.
extension EpisodesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupEpisodesCollectionView() {
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.episodeCell, for: indexPath) as! EpisodesCollectionViewCell
        cell.episodeNumberLabel.text = episodes[indexPath.row].episode
        cell.episodeTitleLabel.text  = episodes[indexPath.row].name
        cell.episodeDateLabel.text   = episodes[indexPath.row].airDate
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let saveAreaWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        let cellSetup = UserInterfaceHelper.setCell(width: saveAreaWidth, height: Constants.Design.cellHeight, padding: Constants.Design.cellPadding)
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
            fetchEpisodes(for: episodesCurrentPage)
        }
    }

}
