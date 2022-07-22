//
//  PersistenceManager.swift
//  MovieList
//
//  Created by Steven Hill on 15/07/2022.
//

import Foundation

class PersistenceManager {
    
    let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    var persistedFavourites = [String]()
    
    func getFavourites() -> [String] {
        guard
            let favouritedMovies = defaults.object(forKey: Keys.favourites) as? Data,
            let favouritesArray = try? JSONDecoder().decode([String].self, from: favouritedMovies)
        else { return [] }
        self.persistedFavourites = favouritesArray
        return self.persistedFavourites
    }
    
    func addToFavourites(name: String) {
        let newFavourite = name

        var faveList: [String] = getFavourites()
        if faveList.contains(newFavourite) {
//        MARK:- TODO: tell the user the movie has already been favourited
        } else {
            faveList.append(newFavourite)
            self.persistedFavourites = faveList
            save()
        }
    }

    func deleteFromFavourites(name: String) {
        persistedFavourites.removeAll { $0 == name }
        save()
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(persistedFavourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
        } catch {
//        MARK:- TODO: tell the user there was an error saving the list
        }
    }
}
