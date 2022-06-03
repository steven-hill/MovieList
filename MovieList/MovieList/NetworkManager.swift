//
//  NetworkManager.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    enum FetchError: Error {
        case invalidURL
        case network(Error)
        case missingResponse
        case unexpectedResponse(Int)
        case invalidData
        case invalidJSON(Error)
    }
    
    func fetch(movieName: String, completion: @escaping (Swift.Result<MovieSearch, FetchError>) -> Void) {
        
        let url = "https://itunes.apple.com/search?term=\(movieName)&entity=movie"
      
        guard let finalUrl = URL(string: url) else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { data, response, error in
            
            guard error == nil else {
                completion(.failure(FetchError.network(error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FetchError.missingResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(FetchError.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedData = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let receivedMovieSearch = try decoder.decode(MovieSearch.self, from: receivedData)
                var names: [String] = []
                for result in receivedMovieSearch.results {
                    names.append(result.trackName)
                }
                completion(.success(receivedMovieSearch))
            } catch {
                completion(.failure(FetchError.invalidJSON(error)))
            }
        }
        task.resume()
    }
}
        
