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
    var movieImages: [UIImage] = []
    var movieController: MovieListVC!

    init(userQueryString: String) {
        self.userQueryString = userQueryString
        networkManager.delegate = self
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

    func fetchImageForMovie(at position: Int,
                            completionHandler: @escaping (Swift.Result<UIImage, Error>) -> Void) {

        let possibleLoadedImage = networkManager.getImage(at: position)
        if let image = possibleLoadedImage {
            completionHandler(.success(image))
        } else {
            let emptyImageError = NSError()
            completionHandler(.failure(emptyImageError as Error))
        }
    }
}

extension MovieListCoordinator: NetworkManagerDelegate {

    func updateMovies(movieSearch: MovieSearch) {
//        networkManager.fetch(movieName: movieName) { Result in
//            switch Result {
//                case .success(let receivedMovieSearch):
//                    DispatchQueue.main.async {
//                        var names: [String] = []
//                        for result in receivedMovieSearch.results {
//                            names.append(result.trackName)
//                        }
//                        self.moviesArray = names
//                        print("names: \(names)")
//                        self.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        let alertController = UIAlertController(title: "Something went wrong: \(error)", message: "Please try again.", preferredStyle: .alert)
//                        let actionTitle = NSLocalizedString("Ok", comment: "")
//                        alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
//                        self.present(alertController, animated: true, completion: nil)
//                        return
//                    }
//            }
//        }
    }

    //    func updateMovies(movieSearch: MovieSearch) {
    //        DispatchQueue.main.async {
    //            var names: [String] = []
    //            for result in movieSearch.results {
    //                names.append(result.trackName)
    //            }
    //            if names.isEmpty {
    //                let alertController = UIAlertController(title: "No movies found", message: "Please try another name.", preferredStyle: .alert)
    //                let actionTitle = NSLocalizedString("Ok", comment: "")
    //                alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
    //                self.present(alertController, animated: true, completion: nil)
    //                return
    //            } else {
    //            self.moviesArray = names
    //            print("names: \(names)")
    //            self.tableView.reloadData()
    //            }
    //        }
    //    }

    func movieSearchError(error: NetworkManager.FetchError) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: "Something went wrong: \(NetworkManager.FetchError.self)", message: "Please try again.", preferredStyle: .alert)
//            let actionTitle = NSLocalizedString("Ok", comment: "")
//            alertController.addAction(.init(title: actionTitle, style: .default, handler: nil))
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
    }

    func updateImages(images: [UIImage]) {
//        DispatchQueue.main.async {
//            self.movieImages = images
//            self.tableView.reloadData()
//            self.dismissLoadingView()
//        }
    }
}
