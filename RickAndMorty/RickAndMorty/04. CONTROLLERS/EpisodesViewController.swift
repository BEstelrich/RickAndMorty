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
    var isLoading: Bool            = false
    var episodesCurrentPage: Int   = 1
    var episodesTotalPages: Int!
    
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodesCollectionView()
        setupObservers()
        fetchEpisodes(for: episodesCurrentPage)
    }
    
    
    // MARK: - Local functions
    private func fetchEpisodes(for page: Int) {
        isLoading = true
        
        NetworkManager2.shared.getEpisodes(for: page) { [weak self] result in
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
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(EpisodesViewController.reloadInterface), name:NSNotification.Name(rawValue: Constants.Observers.reloadEpisodesCollectionView), object: nil)
    }
    
    @objc private func reloadInterface() {
        episodesCollectionView.reloadData()
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let charactersViewController = segue.destination as? CharactersViewController {
            if let indexPath = self.episodesCollectionView.indexPathsForSelectedItems?.last {
                charactersViewController.episodeCharacters = Data.episodesArray[indexPath.row].characters
                charactersViewController.episodeTitle = Data.episodesArray[indexPath.row].episode
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
