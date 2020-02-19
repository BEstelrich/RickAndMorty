//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-30.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

protocol APIData {
    func fetchData()
}

class NetworkManager {
    private let apiData: APIData
    
    init(apiData: APIData) {
        self.apiData = apiData
    }
    
    /// Handles API requests.
    func fetchDataFromAPI() {
        apiData.fetchData()
    }
}

class FetchAPIEpisodes: APIData {
    private let alertManager = AlertManager()
    
    /// Fetch Episodes from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchData() {
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
}

class FetchAPICharacters: APIData {
    private let alertManager = AlertManager()
    
    /// Fetch Episodes from the API.
    /// This method fetchs data straight to model if model classes are conformed to Codable protocol.
    func fetchData() {
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


class NetworkManager2 {
    
    static let shared   = NetworkManager2()
    private let baseURL = "https://rickandmortyapi.com/api/"
    let cache           = NSCache<NSString, UIImage>()
    
    
    private init() {}
    
    
    func getEpisodes(for page: Int, completed: @escaping (Result<EpisodesData, AppError>) -> Void) {
        let endPointURL = baseURL + "episode/?page=\(page)"
        
        guard let url = URL(string: endPointURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder      = JSONDecoder()
                let episodesData = try decoder.decode(EpisodesData.self, from: data)
                completed(.success(episodesData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
}
