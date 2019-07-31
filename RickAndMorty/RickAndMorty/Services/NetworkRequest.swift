//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-30.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class NetworkRequest {
    let requestAPIData = RequestAPIData()
    let parseAPIData = ParseAPIData()
    
    func handler()  {
        requestAPIData.fetchEpisodes()
        requestAPIData.fetchCharacters()

    }
}

class RequestAPIData {
    
    func fetchEpisodes() {
        let url = URL(string: (APIAddresses.episodesURL))
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.episodesArray = try JSONDecoder().decode([Episodes].self, from: data!)
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
    
    func fetchCharacters() {
        let url = URL(string: APIAddresses.charactersURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.charactersArray = try JSONDecoder().decode([Characters].self, from: data!)
                } else {
                    print("There is an error: \(error.debugDescription)")
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
            }.resume()
    }
}

class ParseAPIData {
    func parseEpisodes() {
        
    }
    
    func parseCharacters() {
        
    }
}


class APIAddresses {

    static var charactersURL: String {
        var charactersNumbers = String()
        
        for number in 1...492 {
            charactersNumbers += "\(number),"
        }
        return "https://rickandmortyapi.com/api/character/\(charactersNumbers)" + "493"
    }
    
    
    static var episodesURL: String {
        var episodesNumbers = String()
        
        for number in 1...30 {
            episodesNumbers += "\(number),"
        }
        return "https://rickandmortyapi.com/api/episode/\(episodesNumbers)" + "31"
    }
}

