//
//  NetworkManager.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {

    func updateMovies(movieSearch: MovieSearch)
    
    func movieSearchError(error: NetworkManager.FetchError)
    
    func updateImages(images: [UIImage])
}

class NetworkManager {
    
    enum FetchError: Error {
        case invalidURL
        case network(Error)
        case missingResponse
        case unexpectedResponse(Int)
        case invalidData
        case invalidJSON(Error)
    }
    
    var delegate: NetworkManagerDelegate?
    private var imageURLs: [String] = []

    func fetch(movieName: String, completion: @escaping (Swift.Result<MovieSearch, NetworkManager.FetchError>) -> Void) {
        
        let url = "https://itunes.apple.com/search?term=\(movieName)&entity=movie"
        
        guard let finalUrl = URL(string: url) else {
            let error = FetchError.invalidURL
            self.delegate?.movieSearchError(error: error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalUrl) { data, response, error in
            
            guard error == nil else {
                let error = FetchError.network(error!)
                self.delegate?.movieSearchError(error: error)
                completion(.failure(FetchError.network(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                let error = FetchError.missingResponse
                self.delegate?.movieSearchError(error: error)
                completion(.failure(FetchError.missingResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                let error = FetchError.unexpectedResponse(response.statusCode)
                self.delegate?.movieSearchError(error: error)
                completion(.failure(FetchError.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedData = data else {
                let error = FetchError.invalidData
                self.delegate?.movieSearchError(error: error)
                completion(.failure(FetchError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let receivedMovieSearch = try decoder.decode(MovieSearch.self, from: receivedData)
                self.delegate?.updateMovies(movieSearch: receivedMovieSearch)
                completion(.success(receivedMovieSearch))

                for result in receivedMovieSearch.results {
                    self.imageURLs.append(result.artworkUrl100)
                }

            } catch {
                self.delegate?.movieSearchError(error: FetchError.invalidJSON(error))
                completion(.failure(FetchError.invalidJSON(error)))
            }
        }
        task.resume()
    }
    
    
    func getImage(at position: Int) -> UIImage? {
        guard position >= 0, position < imageURLs.endIndex else {
            return nil
        }

        let preparedURL = URL(string: imageURLs[position])!
        guard let imageData = try? Data(contentsOf: preparedURL),
              let loadedImage = UIImage(data: imageData) else { return nil }

        return loadedImage
    }
}

