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
//        let url = URL(string: (APIAddresses().episodesURL)) ?? URL(string: "https://rickandmortyapi.com/api/episode/[1,2,3,4,5,6,7,8,9,10]")
        let url = URL(string: (APIAddresses().episodesURL))
        print(APIAddresses().episodesURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.episodesArray = try JSONDecoder().decode([Episodes].self, from: data!)
                    print(Data.episodesArray.count)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadInterface"), object: nil)
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
        let url = URL(string: APIAddresses().charactersURL)
        print(APIAddresses().charactersURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    Data.charactersArray = try JSONDecoder().decode([Characters].self, from: data!)
                    print(Data.charactersArray.count)
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

//    let charactersURL = "https://rickandmortyapi.com/api/character/[1,2,3,4,5,6,7,8,9,10]"
    
    var charactersURL: String {
        var charactersNumbers = String()
        
        for number in 1...492 {
            charactersNumbers += "\(number),"
        }
        return "https://rickandmortyapi.com/api/character/\(charactersNumbers)" + "493"
    }
    
    
    var episodesURL: String {
        var episodesNumbers = String()
        
        for number in 1...30 {
            episodesNumbers += "\(number),"
        }
        return "https://rickandmortyapi.com/api/episode/\(episodesNumbers)" + "31"
    }
}

