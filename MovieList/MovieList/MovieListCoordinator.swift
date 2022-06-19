//
//  MoveListCoordinator.swift
//  MovieList
//
//  Created by Alejandro Olivares on 6/9/22.
//

import UIKit

class MovieListCoordinator {

    let userQueryString: String
    let networkManager = NetworkManager()

    var movieNames: [String] = []
    var movieImages: [Int: UIImage] = [:]
    var movieController: MovieListVC!

    init(userQueryString: String) {
        self.userQueryString = userQueryString
    }
}

extension MovieListCoordinator: MovieListVCDelegate {
    func viewDidAppear() {
        networkManager.fetch(movieName: userQueryString) { fetchResult in
            switch fetchResult {
                case .success(let receivedMovieSearch):
                    self.movieNames = receivedMovieSearch.results.map { $0.trackName }
                    self.movieController.updateUI()

                case .failure(_):
                    // TODO: pass alert back to MovieListVC.
                    break
            }
        }
    }

    func fetchImageForMovie(at position: Int) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ continuation in
            let possibleLoadedImage = networkManager.getImage(at: position)
            if let image = possibleLoadedImage {
                continuation.resume(returning: image)
            } else {
                let fetchError = NSError(domain: "Fetching Image", code: -1)
                continuation.resume(throwing: fetchError)
            }
        })
    }
}
