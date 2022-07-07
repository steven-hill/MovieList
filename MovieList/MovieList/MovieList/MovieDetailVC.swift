//
//  MovieDetailVC.swift
//  MovieList
//
//  Created by Steven Hill on 24/06/2022.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailVC: UIViewController {
    
    let movie: MovieResult
    
    var playerContainerView: UIView!
    
    var playerView: UIView!

    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpPlayerContainerView()
        setUpPlayerView()
        setUpPlayButton()
        configureMovieDetails()
        updateUI()
    }

    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        view.addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            playerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func setUpPlayerView() {
        playerView = UIView()
        playerView.backgroundColor = .black
        playerContainerView.addSubview(playerView)
        playerView.addSubview(playButton)
        playerView.bringSubviewToFront(playButton)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerContainerView.heightAnchor, multiplier: 16/9),
            playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor)
        ])
    }
 
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func playButtonTapped() {
        playVideo()
    }
    
    func playVideo() {
        guard let url = URL(string: movie.previewUrl) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
    }
    
    func setUpPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor, constant: 50),
            playButton.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 100),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.image = UIImage(systemName: "photo")
        movieImage.contentMode = .scaleAspectFit
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        return movieImage
    }()
    
    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.font = UIFont.boldSystemFont(ofSize: 16)
        movieName.textAlignment = .left
        movieName.text = "Movie name"
        movieName.numberOfLines = 1
        movieName.adjustsFontSizeToFitWidth = true
        return movieName
    }()
    
    private let movieGenre: UILabel = {
        let movieGenre = UILabel()
        movieGenre.font = UIFont.boldSystemFont(ofSize: 16)
        movieGenre.textAlignment = .left
        movieGenre.text = "Movie genre"
        movieGenre.numberOfLines = 1
        movieGenre.adjustsFontSizeToFitWidth = true
        return movieGenre
    }()
    
    private let movieReleaseDate: UILabel = {
        let movieReleaseDate = UILabel()
        movieReleaseDate.font = UIFont.boldSystemFont(ofSize: 16)
        movieReleaseDate.textAlignment = .left
        movieReleaseDate.text = "Movie release date"
        movieReleaseDate.numberOfLines = 1
        movieReleaseDate.adjustsFontSizeToFitWidth = true
        return movieReleaseDate
    }()
    
    private let movieDescription: UILabel = {
        let movieDescription = UILabel()
        movieDescription.font = UIFont.boldSystemFont(ofSize: 16)
        movieDescription.textAlignment = .left
        movieDescription.text = "Movie description"
        movieDescription.numberOfLines = 10
        return movieDescription
    }()
    
    private let favouritesButton: UIButton = {
        let favouritesButton = UIButton()
        favouritesButton.setTitle("Add to favourites", for: .normal)
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        return favouritesButton
    }()
    
    @objc func favouritesButtonTapped() {
        // add the movie to favourites
    }
    
    private func configureMovieDetails() {
        view.addSubview(movieImage)
        view.addSubview(movieName)
        view.addSubview(movieGenre)
        view.addSubview(movieReleaseDate)
        view.addSubview(movieDescription)
        view.addSubview(favouritesButton)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieGenre.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieImage.heightAnchor.constraint(equalToConstant: 100),
            movieImage.widthAnchor.constraint(equalToConstant: 67),
            
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20),
            movieName.heightAnchor.constraint(equalToConstant: 20),
            movieName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            movieGenre.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieGenre.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 20),
            movieGenre.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20),
            movieGenre.heightAnchor.constraint(equalToConstant: 20),
            movieGenre.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            movieReleaseDate.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 20),
            movieReleaseDate.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20),
            movieReleaseDate.heightAnchor.constraint(equalToConstant: 20),
            movieReleaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            movieDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieDescription.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 20),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieDescription.heightAnchor.constraint(equalToConstant: 180),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            favouritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favouritesButton.topAnchor.constraint(equalTo: movieDescription.bottomAnchor, constant: 30),
            favouritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            favouritesButton.heightAnchor.constraint(equalToConstant: 20),
            favouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    func updateUI() {
        movieName.text = movie.trackName
        movieGenre.text = movie.primaryGenreName
        movieReleaseDate.text = movie.releaseDate
        movieDescription.text = movie.longDescription
    }
}
