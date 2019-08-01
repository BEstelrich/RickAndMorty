//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-30.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class NetworkRequest {
    private let requestAPIData = RequestAPIData()
    
    /// Handles all API requests.
    func fetchingAPIs()  {
        requestAPIData.fetchEpisodes()
        requestAPIData.fetchCharacters()
    }
}

class RequestAPIData {
    private let alertManager = AlertManager()
    
    /// Fetch Episodes from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchEpisodes() {
        guard let url = URL(string: Constants.API.episodesURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if error == nil {
                    Data.episodesArray = try JSONDecoder().decode([Episode].self, from: data!)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observers.reloadEpisodesCollectionView), object: nil)
                    }
                } else {
                    print("Error parsing Episodes JSON: \(error.debugDescription)")
                    DispatchQueue.main.async {
                        self.alertManager.showEpisodesErrorAlert()
                    }
                }
            } catch {
                print("Error parsing Episodes JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.alertManager.showEpisodesErrorAlert()
                }
            }
        }.resume()
    }
    
    /// Fetch Characters from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchCharacters() {
        guard let url = URL(string: Constants.API.charactersURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if error == nil {
                    Data.charactersArray = try JSONDecoder().decode([Character].self, from: data!)
                } else {
                    print("Error parsing Characters JSON: \(error.debugDescription)")
                    DispatchQueue.main.async {
                        self.alertManager.showCharactersErrorAlert()
                    }
                }
            } catch {
                print("Error parsing Characters JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.alertManager.showCharactersErrorAlert()
                }
            }
        }.resume()
    }
    
}
