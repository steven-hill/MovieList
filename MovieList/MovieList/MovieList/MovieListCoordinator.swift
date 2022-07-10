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

    var movies: [MovieResult] = []
    var movieImages: [Int: UIImage] = [:]
    var movieController: MovieListVC!
    
    let child = SpinnerVC()

    init(userQueryString: String) {
        self.userQueryString = userQueryString
    }
}

extension MovieListCoordinator: MovieListVCDelegate {
    func viewDidAppear() {
        networkManager.fetch(movieName: userQueryString) { fetchResult in
            switch fetchResult {
                case .success(let receivedMovieSearch):
                    self.movies = receivedMovieSearch.results
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
    
    func didSelectRow(at: Int) {
        guard movies.count > at else { return }
        let movieDetailVC = MovieDetailVC(movie: movies[at])
        movieDetailVC.movieImage.image = movieImages[at]
        movieController.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    //MARK: - SpinnerView Methods
    
    func configureSpinnerView() {
        let child = child
        child.loadView()
    }
    
    func createSpinnerView() {
        movieController.addChild(child)
        child.view.frame = movieController.view.frame
        movieController.view.addSubview(child.view)
        child.didMove(toParent: movieController)
    }
    
    func removeSpinnerView() {
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}
