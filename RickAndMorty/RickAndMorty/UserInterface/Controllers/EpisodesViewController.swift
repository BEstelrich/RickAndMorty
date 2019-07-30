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
        NotificationCenter.default.addObserver(self, selector: #selector(EpisodesViewController.reloadInterface), name:NSNotification.Name(rawValue: "reloadInterface"), object: nil)
    }
    


}

extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupEpisodesCollectionView() {
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of rows")
        return Data.episodesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = episodesCollectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCollectionViewCell
        cell.episodeNumberLabel.text = Data.episodesArray[indexPath.row].episode
        cell.episodeTitleLabel.text = Data.episodesArray[indexPath.row].name
        cell.episodeDateLabel.text = Data.episodesArray[indexPath.row].airDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}

extension EpisodesViewController: InterfaceDelegate {
    @objc func reloadInterface() {
        episodesCollectionView.reloadData()
    }
}
