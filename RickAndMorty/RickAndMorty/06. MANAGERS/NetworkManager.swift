//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by BES on 2019-07-30.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
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
    
    
    func getCharactersCount(completed: @escaping (Result<CharactersData, AppError>) -> Void) {
        let endPointURL = baseURL + "character/"
        
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
                let decoder        = JSONDecoder()
                let charactersData = try decoder.decode(CharactersData.self, from: data)
                completed(.success(charactersData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func getCharacters(from id: String, completed: @escaping (Result<[Character], AppError>) -> Void) {
        let endPointURL = baseURL + "character/\(id)"
        
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
                let episodesData = try decoder.decode([Character].self, from: data)
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
