//
//  PersistenceCoordinator.swift
//  MovieList
//
//  Created by Steven Hill on 15/07/2022.
//

import Foundation

class FavouritesCoordinator {
    
    var favourites: [String] = []
    let persistenceManager = PersistenceManager()

    init() {
    }
}

extension FavouritesCoordinator: FavouritesListVCDelegate {

    func loadFavourites() {
        favourites = persistenceManager.getFavourites()
    }
    
    func deleteMovieFromFavourites(name: String) {
        persistenceManager.deleteFromFavourites(name: name)
    }
}
