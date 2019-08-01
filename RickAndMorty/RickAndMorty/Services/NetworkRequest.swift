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
    
    /// Fetch Episodes from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchEpisodes() {
        let url = URL(string: (Constants.API.episodesURL))
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.episodesArray = try JSONDecoder().decode([Episode].self, from: data!)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Observers.reloadEpisodesCollectionView), object: nil)
                    }

                } else {
                    print("There is an error: \(error.debugDescription)")
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    /// Fetch Characters from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchCharacters() {
        let url = URL(string: Constants.API.charactersURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.charactersArray = try JSONDecoder().decode([Character].self, from: data!)
                } else {
                    print("There is an error: \(error.debugDescription)")
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
            }.resume()
    }
}
