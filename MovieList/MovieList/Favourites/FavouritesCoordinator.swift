//
//  PersistenceCoordinator.swift
//  MovieList
//
//  Created by Steven Hill on 15/07/2022.
//

import Foundation
import UIKit

class FavouritesCoordinator {
    
    var favourites: [MovieResult] = []
    let persistenceManager = PersistenceManager()

    init() {
    }
}

extension FavouritesCoordinator: FavouritesListVCDelegate {
    
    func loadFavourites() {
        persistenceManager.getFavourites()
    }
    
    func deleteMovieFromFavourites(movie: MovieResult) {
        persistenceManager.deleteFromFavourites(movie: movie)
    }
}
    
extension FavouritesCoordinator: MovieDetailVCDelegate {
    
    func addMovieToFavourites(movie: MovieResult) {
        persistenceManager.addToFavourites(movie: movie)
    }
}
