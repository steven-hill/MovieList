//
//  PersistenceCoordinator.swift
//  MovieList
//
//  Created by Steven Hill on 15/07/2022.
//

import Foundation
import UIKit

class PersistenceCoordinator {
    
    var favourites: [MovieResult] = []
    let persistenceManager = PersistenceManager()

    init(favourites: [MovieResult]) {
        self.favourites = favourites
    }
}

extension PersistenceCoordinator: FavouritesListVCDelegate {
    
    func loadFavourites() {
        persistenceManager.getFavourites()
    }
    
    func deleteMovieFromFavourites(movie: MovieResult) {
        persistenceManager.deleteFromFavourites(movie: movie)
    }
}
    
extension PersistenceCoordinator: MovieDetailVCDelegate {
    
    func addMovieToFavourites(movie: MovieResult) {
        persistenceManager.addToFavourites(movie: movie)
    }
}
