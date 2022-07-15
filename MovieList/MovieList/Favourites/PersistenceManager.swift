//
//  PersistenceManager.swift
//  MovieList
//
//  Created by Steven Hill on 15/07/2022.
//

import Foundation

class PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    var favourites: [MovieResult] = [] {
        didSet {
            save()
        }
    }
    
    func getFavourites() {
        guard
            let favouritedMovies = PersistenceManager.defaults.object(forKey: Keys.favourites) as? Data,
            let favourites = try? JSONDecoder().decode([MovieResult].self, from: favouritedMovies)
        else { return }
        self.favourites = favourites
    }
    
    func addToFavourites(movie: MovieResult) {
        let newFavourite = MovieResult(trackName: movie.trackName, artworkUrl100: movie.artworkUrl100, primaryGenreName: movie.primaryGenreName, longDescription: movie.longDescription, releaseDate: movie.releaseDate, previewUrl: movie.previewUrl)
        
        guard !favourites.contains(where: { movie in
            favourites.append(newFavourite)
            return true
        }) else { return }
    }
    
    func deleteFromFavourites(movie: MovieResult) {
        favourites.removeAll { $0.trackName == movie.trackName }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            PersistenceManager.defaults.set(encodedFavourites, forKey: Keys.favourites)
        } catch {
            // deal with the error
        }
    }
}
