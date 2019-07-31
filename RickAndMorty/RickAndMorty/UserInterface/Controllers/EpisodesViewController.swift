//
//  ViewController.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-29.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController  {
    
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodesCollectionView()
        NetworkRequest().handler()
        NotificationCenter.default.addObserver(self, selector: #selector(EpisodesViewController.reloadInterface), name:NSNotification.Name(rawValue: Constants.Observers.reloadEpisodesCollectionView), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.Segues.episodeCharactersSegue:
                if let charactersViewController = segue.destination as? CharactersViewController {
                    if let indexPath = self.episodesCollectionView.indexPathsForSelectedItems?.last {
                        charactersViewController.characters = Data.episodesArray[indexPath.row].characters
                    }
                }
            default:
                break
            }
        }
    }

}

extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupEpisodesCollectionView() {
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
        let padding: CGFloat = 100
        if UIDevice.current.userInterfaceIdiom == .phone  {
            return CGSize(width: UIScreen.main.bounds.width, height: 50)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if UIApplication.shared.statusBarOrientation.isPortrait {
                return CGSize(width: (UIScreen.main.bounds.width - padding)/2, height: 50)
            } else {
                return CGSize(width: (UIScreen.main.bounds.width - padding)/3, height: 50)
            }
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}

extension EpisodesViewController: InterfaceDelegate {
    @objc func reloadInterface() {
        episodesCollectionView.reloadData()
    }
}
