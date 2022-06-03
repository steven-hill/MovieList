//
//  MovieData.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import Foundation

// MARK: - MovieSearch
struct MovieSearch: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let trackName: String
    let artworkUrl100: String
}
