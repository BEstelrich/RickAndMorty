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
    

    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodesCollectionView()
        setupObservers()
        fetchData()
    }
    
    
    // MARK: - Local functions
    private func fetchData() {
        let episodesAPI = NetworkRequest(apiData: FetchAPIEpisodes())
        let charactersAPI = NetworkRequest(apiData: FetchAPICharacters())
        
        episodesAPI.fetchDataFromAPI()
        charactersAPI.fetchDataFromAPI()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(EpisodesViewController.reloadInterface), name:NSNotification.Name(rawValue: Constants.Observers.reloadEpisodesCollectionView), object: nil)
    }
    
    @objc private func reloadInterface() {
        episodesCollectionView.reloadData()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.Segues.episodeCharactersSegue:
                if let charactersViewController = segue.destination as? CharactersViewController {
                    if let indexPath = self.episodesCollectionView.indexPathsForSelectedItems?.last {
                        charactersViewController.episodeCharacters = Data.episodesArray[indexPath.row].characters
                        charactersViewController.episodeTitle = Data.episodesArray[indexPath.row].episode
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
extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func setupEpisodesCollectionView() {
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.episodesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.episodeCell, for: indexPath) as! EpisodesCollectionViewCell
        cell.episodeNumberLabel.text = Data.episodesArray[indexPath.row].episode
        cell.episodeTitleLabel.text = Data.episodesArray[indexPath.row].name
        cell.episodeDateLabel.text = Data.episodesArray[indexPath.row].airDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let saveAreaWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        let cellSetup = CellSetup().setCell(width: saveAreaWidth, height: Constants.Design.cellHeight, padding: Constants.Design.cellPadding)
        return cellSetup
    }
}
