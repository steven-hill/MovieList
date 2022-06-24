//
//  MovieData.swift
//  MovieList
//
//  Created by Steven Hill on 03/06/2022.
//

import Foundation

// MARK: - MovieSearch
struct MovieSearch: Codable {
    let results: [MovieResult]
}

// MARK: - MovieResult
struct MovieResult: Codable {
    let trackName: String
    let artworkUrl100: String
    let primaryGenreName: String
    let longDescription: String
    let releaseDate: String
    let previewUrl: String
}
